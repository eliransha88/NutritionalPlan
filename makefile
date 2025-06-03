SHELL := /bin/sh
#config here

CONFIGURATION = Debug
OUTPUT_DIR = $(CURDIR)/build
WORKSPACE  = NutritionalPlan
IS_BUILT_FOR_TESTS_ON_CI = false
BUILD_FOR_USERTESTING = false
SHOULD_RUN_SWIFTLINT = false

BUNDLER_VERSION = 2.2.4
#end of config section

USERNAME = $(shell whoami)

comma:= ,
empty:=
space:= $(empty) $(empty)
amp:= &

TESTPARAMS = archive -sdk iphoneos
BUILDFOLDERSUFFIX = iphoneos
ifneq ($(strip $(TEST)),)
	TESTPARAMS = build -sdk iphonesimulator
	BUILDFOLDERSUFFIX = iphonesimulator
endif

FORCEPROD = $(empty)
ifneq ($(strip $(FORCE_PROD)),)
	FORCEPROD = FORCEPROD=1
endif

BUILD_PRODUCTS_DIR := $(OUTPUT_DIR)/$(WORKSPACE)/Build/Products/$(CONFIGURATION)-$(BUILDFOLDERSUFFIX)

# Fastlane Pipelines

upload-to-store: bundle-install
	bundle exec fastlane upload_to_store api_key:'$(APPSTORE_API_KEY)' --env '$(APP_NAME)'

submit-to-review: bundle-install
	bundle exec fastlane submit_review api_key:'$(APPSTORE_API_KEY)' auto_release:'$(AUTO_RELEASE)' --env '$(APP_NAME)'

upload-dsym: bundle-install
	bundle exec fastlane upload_dsyms configuration:'$(BUILD_CONFIGURATION)' forceDsymUpload:'$(UPLOAD_DSYM)' --env '$(APP_NAME)'

prepare-remote-config: bundle-install
	bundle exec fastlane create_remote_config --env '$(APP_NAME)'

archive: bundle-install
	bundle exec fastlane archive_pipeline configuration:'$(BUILD_CONFIGURATION)' keychain_pass:'$(KEYCHAINPASS)' bundle_version:'$(BUNDLE_VERSION)' --env '$(APP_NAME)';

pre-deploy-validation: bundle-install
	bundle exec fastlane validate_release_branch --env '$(APP_NAME)'

build-for-testing: bundle-install
	bundle exec fastlane build_for_testing --env '$(APP_NAME)'

run-unit-test: bundle-install
	bundle exec fastlane run_unit_testing --env '$(APP_NAME)'

run-system-test: bundle-install
	bundle exec fastlane run_system_testing --env '$(APP_NAME)'

unit-test: bundle-install
	bundle exec fastlane run_unit_tests_pipline --env '$(APP_NAME)'

system-test: bundle-install
	bundle exec fastlane run_system_tests_pipline --env '$(APP_NAME)'

report-native-performance: bundle-install
	bundle exec fastlane report_ipa_size --env '$(APP_NAME)'

upload-to-firebase: bundle-install
	bundle exec fastlane upload_build_to_firebase --env '$(APP_NAME)'

bump-version: bundle-install
	bundle exec fastlane bump_build_version api_key:'$(APPSTORE_API_KEY)' build_number:'$(BUILD_NUMBER)' --env '$(APP_NAME)'

# End of Fastlane Piplines

# runs bundle install and configures bundler to install gems locally
bundle-install:
	time make install-dependecies
	# install gems locally to improve machine being agnostic and allow gitlab runners to cache the gems
	# to return to system location use: `bundle config set --local system 'true'`
	bundle config set --local path 'vendor/bundle'
	time bundle install

# install - is used to install the workstation dependecies and get it ready for running the project
install: install-workstation

install-workstation: install-dependecies
	time bundle install

install-dependecies:
	# No need to run it every time, I'm keeping it here just in case we'll wait to enable it
	#time make install-homebrew
	type xcbeautify 2>/dev/null || { echo "installing xcbeautify" ; brew install xcbeautify; }
	type mogenerator 2>/dev/null || { echo "installing mogenerator"; brew install mogenerator; }
	type sourcery 2>/dev/null || { echo "installing sourcery"; brew install sourcery; }
	type mise 2>/dev/null || { echo "installing mise"; time make install-mise; }
	type jq 2>/dev/null || { echo "installing jq"; brew install jq; }
	type appleSimUtil 2>/dev/null || { echo "installing appleSimUtil"; brew tap wix/brew; brew install applesimutils; }
	type swiftlint 2>/dev/null || { echo "installing swiftlint"; brew install swiftlint; }
	time make install-tuist
	type licenseplist 2>/dev/null || { echo "installing licenseplist" ; brew install licenseplist; }
	if [$IS_BUILT_FOR_TESTS_ON_CI]; then \
		type pythonGitlab 2>/dev/null || { echo "installing python gitlab" ; pip install --upgrade python-gitlab; }; \
	fi
	time make copy-git-hooks
	time make install-bundler

# If Homebrew is installed -> update it, else install it.
install-homebrew:
	type brew 2>/dev/null && { echo "Updating Homebrew"; brew update; }
	type brew 2>/dev/null || { echo "installing Homebrew"; /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"; }

# Target to ensure Tuist is installed and at the correct version
# Example Makefile snippet

install-mise:
	brew install mise
	echo "eval \"\$$($$HOME/.local/bin/mise activate zsh)\"" >> "$$HOME/.zshrc"
	echo 'export PATH="$$HOME/.local/share/mise/shims:$$PATH"' >> ~/.bash_profile
	echo 'export PATH="$$HOME/.local/share/mise/shims:$$PATH"' >> ~/.zprofile
	mise install
	mise activate --shims

install-tuist:
	mise install tuist

# Installs ruby bundler and coocapods
install-bundler:
	# Install bundler if not found
	type bundler 2>/dev/null || { echo "installing Bundler"; gem install bundler:$(BUNDLER_VERSION); }
	# Updates bundler if not in correct version (i.e output "Bundler version 2.2.4")
	# No need to run it every time, I'm keeping it here just in case we'll wait to enable it
	#bundler --version | grep $(BUNDLER_VERSION) || { echo "Updating Bundler"; gem install bundler:$(BUNDLER_VERSION); }

generate:
	tuist generate

# SwiftLint
run-swiftlint:
	if [$(SHOULD_RUN_SWIFTLINT); then \
    	swiftlint; \
    else \
    	echo "You should change above variable to true, Don't forget to change it back"; \
    fi

# Generates a google service plist to use.
# It is being in the XCode build phase script, it takes the `GoogleService-Info.plist` file for the app that is being built and copies it to the mentioned path.
generate-google-service-plist:
	cp $(shell ls -1 ./AppResources/GoogleConfig/Config/**/GoogleService-${BUNDLE_ID}-Info.plist) ./AppResources/GoogleConfig/GoogleService-Info.plist

# Generates licenses files from cocoapods for the apps
generate-licenses:
	# Generate plist (as default) and html licenses files based on Cartfile and Package.resolved
	license-plist --package-path ./Tuist/Package.resolved --html-path ./Modules/NutritionalPlanCore/NutritionalPlanCore/Assets/Licenses.html --output-path licensesplist-can-remove --suppress-opening-directory --config-path ./AppResources/Licenses/licensesConfig.yml --force
	# Since we're only using the html file, we can remove the plist dir
	rm -d -r licensesplist-can-remove

# Lists all available make commands
list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'


module:
	# Update the autogenerated AppDIAssembliesSetup file with the new module
	#awk 'BEGIN{last=0} /assembliesNamesSet.insert/{last=NR} END{print last}' ./AppResources/DI/Autogenerated/AppDIAssembliesSetup.generated.swift > lastline.txt
	#awk -v n=$$(cat lastline.txt) 'NR==n{print;print "\t\tassembliesNamesSet.insert(\"$(NAME).$(NAME)DIAssembly\")"; next} 1' ./AppResources/DI/Autogenerated/AppDIAssembliesSetup.generated.swift > tmp && mv tmp ./AppResources/DI/Autogenerated/AppDIAssembliesSetup.generated.swift
	#rm lastline.txt
	# Get the Name param with the first letter as lowercased
	@FIRST_LOWER=$(shell echo $(NAME) | awk '{print tolower(substr($$0,1,1)) substr($$0,2)}') ; \
	echo "First letter lowercased: $$FIRST_LOWER"; \
	tuist scaffold ModuleTemplate --name $(NAME) --lcname $$FIRST_LOWER

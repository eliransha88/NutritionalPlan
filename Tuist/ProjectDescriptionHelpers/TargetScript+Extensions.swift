//
//  TargetScript+Extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by Eliran Sharabi on 15/05/2022.
//

import ProjectDescription

public extension TargetScript {
    
    static let rootFolder: String = "$SRCROOT/../.."
    
    // MARK: Adds a generate mocks script phase
    /// - Parameters:
    ///   - moduleName: Module name to apply the script to it
    ///   - parentFolder: Module parent name - if exists
    ///   - shouldRunCuckoo: A flag that indicates if the script should run - as default we don't want to run the script at each test build, once you want to run the script you can change it to true at the build phase itself
    ///   - additionalTestableModules: By default only the module will be define as testable module, in case you want to add another one you can add it here. ex: "NutritionalPlanCore"
    ///   - outputFileDir: Output file dir for the GeneratedMocks.swift file, default: module tests folder.
    ///   - moduleFilePaths: LIst of files to be generated relative to module dir.
    ///   - additionalFilePaths: List of files relative to Modules dir ex. "NutritionalPlanCore/NutritionalPlanCore/Sources..|
    ///   - exclude: Types to exculde.
    static func cuckoo(moduleName: String,
                       parentFolder: String? = nil,
                       shouldRunCuckoo: Bool = false,
                       additionalTestableModules: [String] = [],
                       outputFileDir: String? = nil,
                       moduleFilePaths: [String],
                       additionalFilePaths: [String] = [],
                       exclude: String? = nil) -> TargetScript {
        
        let defaultOutputDir = PathHelper.getTargetPath(targetType: .unitTests,
                                                    moduleName: moduleName,
                                                    parentFolder: parentFolder)
        let modulePath = PathHelper.getSourcesPath(targetType: .module,
                                                   moduleName: moduleName,
                                                   parentFolder: parentFolder)
        
        let outputDir: String = outputFileDir ?? defaultOutputDir
        let modulesDir: String = "\(rootFolder)/Modules/"
        // Construct file paths for moduleFilePaths
        var fullPathModuleFilePaths = moduleFilePaths.map({ return "\"\(modulesDir)\(modulePath)/\($0)"})
        // Construct file paths for additionalFilePaths
        fullPathModuleFilePaths.append(contentsOf: additionalFilePaths.map({return "\"\(modulesDir)\($0)"}))
        
        var filesScript: String = ""
        for (index, path) in fullPathModuleFilePaths.enumerated() {
            /// the last line should never end with a backslash
            filesScript += "\(path)\" \(index != fullPathModuleFilePaths.endIndex - 1 ? "\\" : "")\n"
        }
        
        var finalFilesScript = ""
        
        // Append exclude string
        var typesToExcludeCommand = ""
        if let exclude = exclude {
            typesToExcludeCommand = "--exclude \"\(exclude)\" \\"
            finalFilesScript = "\(typesToExcludeCommand)\n\(filesScript)"
        } else {
            finalFilesScript = filesScript
        }
        
        // Append testable module and additionalTestableModule
        var testableModules = "\(moduleName)"
        for additionalTestableModule in additionalTestableModules {
            testableModules = "\(testableModules)\",\"\(additionalTestableModule)"
        }
        
        let script =
        """
        # Change this value to "true" if you want to run the script
        should_run_script=\(shouldRunCuckoo)
        
        if [ $should_run_script = false ]; then exit 0; fi
        if [ $ACTION = "indexbuild" ]; then exit 0; fi
        
        # Skip for preview builds
        if [ "${ENABLE_PREVIEWS}" = "YES" ]; then
          echo "Not running Cuckoo generator during preview builds."
          exit 0
        fi
        
        ROOT_DIR=$(git rev-parse --show-toplevel)
        OUTPUT="${ROOT_DIR}/Modules/\(outputDir)/GeneratedMocks.swift"
        
        echo "Generated Mocks File = $OUTPUT"

        # Generate mock files, include as many input files as you'd like to create mocks for.
        "${ROOT_DIR}/Tuist/.build/checkouts/Cuckoo/run" generate \\
        --testable \"\(testableModules)\" \\
        --no-timestamp \\
        --output \"$OUTPUT\" \\
        \(finalFilesScript)
        # After running once, locate `GeneratedMocks.swift` and drag it into your Xcode test target group.
        """
        
        return TargetScript.pre(
            script: script,
            name: "Generate Mocks",
            outputPaths: [
                .relativeToModules("\(outputDir)/GeneratedMocks.swift")
            ],
            basedOnDependencyAnalysis: true
        )
    }

    
    // MARK: Update google service plist to the releavnt one (depends on the PRODUCT_BUNDLE_IDENTIFIER)
    static func updateGoogleServicePlist() -> TargetScript {
        let script =
        """
            make -C "\(rootFolder)" generate-google-service-plist BUNDLE_ID=${PRODUCT_BUNDLE_IDENTIFIER}
        """
        
        return TargetScript.pre(
            script: script,
            name: "Generate Google Service plist",
            outputPaths: [.relativeToAppResources("GoogleConfig/GoogleService-Info.plist")])
    }
    
    // MARK: Empty kif screenshot folder
    static func emptyKifScreenshotsFolder() -> TargetScript {
        let script =
        """
            rm -f "../../KIFScreenShots/"*.png
        """
        
        return TargetScript.pre(
            script: script,
            name: "Empty kif screenshots folder")
    }
    
    
    // MARK: Encode config files - generate the .enc file
    static func crashlytics() -> TargetScript {
        let script =
        """
            "\(rootFolder)/Tuist/.build/checkouts/firebase-ios-sdk/Crashlytics/run"
        """
        
        return TargetScript.post(
            script: script,
            name: "Upload dsyms to crashlytics",
            inputPaths: ["${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}", "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${PRODUCT_NAME}",
                        "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Info.plist",
                        "$(TARGET_BUILD_DIR)/$(EXECUTABLE_PATH)"],
            inputFileListPaths: [.relativeToAppResources("GoogleConfig/GoogleService-Info.plist")],
            outputPaths: [])
    }
}

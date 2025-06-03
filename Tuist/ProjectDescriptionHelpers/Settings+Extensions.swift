//
//  Settings+Extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by Eliran Sharabi on 26/05/2022.
//

import ProjectDescription

struct ConfigurationName {
    static let debug: ProjectDescription.ConfigurationName = "Debug"
    static let release: ProjectDescription.ConfigurationName = "Release"
}

public extension Settings {

    /// Should be used when no special settings are needed
    /// Will create a base settings with the default configuraion
    static let empty: Settings = {
        return createSettings(configurations: .emptyConfiguration())
    }()

    /// Should be used for app projects
    /// Will create a setting with default configuration and NutritionalPlanProject.xcconfig
    static let appProject: Settings = {
        return createSettings(configurations: [
            .debug(name: ConfigurationName.debug,
                   xcconfig: .relativeToAppResources("xcconfig/NutritionalPlanProject.xcconfig")),
            .release(name: ConfigurationName.release,
                     xcconfig: .relativeToAppResources("xcconfig/NutritionalPlanProject.xcconfig"))
        ])
    }()
    
    /// Should be used for modules
    /// Will create a base settings with the default configuraion and recommended settings
    static let module: Settings = {
        return .settings(
            base: ["CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER": "NO"],
            configurations: .emptyConfiguration(),
            defaultSettings: DefaultSettings.recommended)
    }()
    
    /// Should be used for modules
    /// Will create a base settings with the default configuraion and relvant settings for system tests
    static func systemTests(targetName: String) -> Settings {
        return .settings(
            base: ["OTHER_LDFLAGS": "-ObjC"
                  ],
            configurations: .emptyConfiguration(),
            defaultSettings: .recommended(excluding: ["CODE_SIGN_IDENTITY"]))
    }
    
    /// Used for app targets
    /// Will create a base settings with the default configuraion and relvant settings for app target
    static func app(for app: String) -> Settings {
        return createSettings(configurations: .appConfiguration(for: app))
    }
    
    // MARK: Private functions
    private static func createSettings(configurations: [Configuration]) -> Settings {
        return .settings(
            base: baseSettings,
            configurations: configurations,
            defaultSettings: DefaultSettings.recommended(excluding: [
                "ASSETCATALOG_COMPILER_APPICON_NAME",
                "CODE_SIGN_IDENTITY",
                "DEBUG_INFORMATION_FORMAT",
                "COPY_PHASE_SCRIPT"
            ])
        )
    }
    
    private static let baseSettings: SettingsDictionary = {
        return ["ENABLE_BITCODE": "NO",
                "OTHER_LDFLAGS": "-ObjC",
                "CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER": "NO"
        ]
    }()
}

extension Array where Element == Configuration {
    
    fileprivate static func appConfiguration(for app: String) -> [Element] {
        return [
            .debug(
                name: ConfigurationName.debug,
                xcconfig: .relativeToAppResources("xcconfig/\(app).xcconfig")
            ),
            .release(
                name: ConfigurationName.release,
                xcconfig: .relativeToAppResources("xcconfig/\(app).xcconfig")
            )
        ]
    }
    
    /// For modules that only needs to have the configuration types without any actual xcconfig,
    /// otherwise won't compile.
    /// Not suitable for modules that need values inside xcconfig
    public static func emptyConfiguration() -> [Element] {
        return [
            .debug(name: ConfigurationName.debug),
            .release(name: ConfigurationName.release)
        ]
    }
}

//
//  Settings+Extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by Gal Orlanczyk on 26/05/2022.
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

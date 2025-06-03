//
//  Target+NutritionalPlan.swift
//  ProjectDescriptionHelpers
//
//  Created by Eliran Sharabi on 11/09/2022.
//

import ProjectDescription

private let appName: String = "NutritionalPlan"

public extension Target {
    static let nutritionalPlanAppTarget: Target = {
        return app(
            name: appName,
            infoPlist: .extendingDefault(with: [
                "UIBackgroundModes": [
                "remote-notification"
                ],
                "CFBundleDisplayName": "$(APP_NAME)",
                "LSApplicationQueriesSchemes": "whatsapp",
                "UILaunchScreen": [:],
                "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
            ]),
            resources: [
                
            ],
            dependencies: .references([
                .nutritionalPlanHome
            ]),
            debugDependencies: .references([
                
            ])
        )
    }()
}

public extension Path {
    static let nutritionalPlanAppPath: Path = .relativeToApps(appName)
}

public extension Reference {
    nonisolated(unsafe) static let nutritionalPlanApp = Reference(schemeName: "\(appName)Scheme",
                                    projectPath: .nutritionalPlanAppPath,
                                    target: .nutritionalPlanAppTarget)
}

public extension Scheme {
    static let nutritionalPlanScheme = Scheme.app(appName: appName,
                                        ref: .nutritionalPlanApp)
}

import ProjectDescription
import ProjectDescriptionHelpers

let projectName: String = "NutritionalPlan"

let project = Project(
    name: projectName,
    organizationName: "Eliran Sharabi",
    options: .options(developmentRegion: "en"),
    settings: .app(for: projectName),
    targets: [
        .target(
            name: projectName,
            destinations: .iOS,
            product: .app,
            bundleId: "${BUNDLE_ID}",
            deploymentTargets: .default,
            infoPlist: .extendingDefault(
                with: [
                    "UIBackgroundModes": [
                    "remote-notification"
                    ],
                    "CFBundleDisplayName": "$(APP_NAME)",
                    "LSApplicationQueriesSchemes": "whatsapp",
                    "UILaunchScreen": [:],
                ]
            ),
            sources: ["\(projectName)/Sources/**"],
            resources: ["\(projectName)/Resources/**"],
            dependencies: [
                .external(name: "SFSafeSymbols")
            ],
            settings: .app(for: projectName)
        ),
        .target(
            name: "\(projectName)Tests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "${BUNDLE_ID}.tests",
            infoPlist: .default,
            sources: ["NutritionalPlan/Tests/**"],
            resources: [],
            dependencies: [.target(name: projectName)],
            settings: Settings.app(for: projectName)
        ),
    ]
)

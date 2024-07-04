import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "NutritionalPlan",
    options: .options(developmentRegion: "he"),
    targets: [
        .target(
            name: "NutritionalPlan",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.NutritionalPlan",
            deploymentTargets: .default,
            infoPlist: .extendingDefault(
                with: [
                    "LSApplicationQueriesSchemes": "whatsapp",
                    "UILaunchScreen": [:],
                ]
            ),
            sources: ["NutritionalPlan/Sources/**"],
            resources: ["NutritionalPlan/Resources/**"],
            dependencies: [
                .external(name: "SFSafeSymbols")
            ]
        ),
        .target(
            name: "NutritionalPlanTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.NutritionalPlanTests",
            infoPlist: .default,
            sources: ["NutritionalPlan/Tests/**"],
            resources: [],
            dependencies: [.target(name: "NutritionalPlan")]
        ),
    ]
)

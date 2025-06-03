// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

let packageSettings = PackageSettings(
    baseSettings: .settings(
        base: [:],
        configurations: [
            .debug(name: "Debug", settings: [:]),
            .release(name: "Release", settings: [:])
        ]
    ),
    targetSettings: [
        "Cuckoo": ["ENABLE_TESTING_SEARCH_PATHS": "YES"]
    ]
)
#endif

let package = Package(
    name: "NutritionalPlan",
    dependencies: [
        .package(url: "https://github.com/SFSafeSymbols/SFSafeSymbols", from: "5.3.0"),
        .package(url: "https://github.com/Swinject/Swinject.git", exact: "2.8.4"),
        .package(url: "https://github.com/kif-framework/KIF.git", exact: "3.8.9"),
        .package(url: "https://github.com/Brightify/Cuckoo.git", exact: "1.10.4")
    ]
)

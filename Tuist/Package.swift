// swift-tools-version: 5.9
import PackageDescription
import ProjectDescriptionHelpers

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,] 
        baseSettings: .settings(configurations: .emptyConfiguration())
    )
#endif

let package = Package(
    name: "NutritionalPlan",
    dependencies: [
        // Add your own dependencies here:
        // You can read more about dependencies here: https://docs.tuist.io/documentation/tuist/dependencies
        .package(url: "https://github.com/SFSafeSymbols/SFSafeSymbols", from: "5.3.0")
    ]
)

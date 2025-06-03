//
//  Target+PAQWidget.swift
//  ProjectDescriptionHelpers
//
//  Created by Eliran Sharabi on 31/08/2022.
//

//import ProjectDescription
//
//public extension Target {
//    private static let targetName = "PaQ"
//    static let paqWidgetModule: Target = .targetModule(targetType: .appWidget,
//                                                       targetName: targetName,
//                                                       bundleId: "$(BUNDLE_ID)",
//                                                       infoPlist: .extendingDefault(with: [
//                                                        "CFBundleDisplayName": "$(PRODUCT_NAME)",
//                                                        "NSExtension": [
//                                                            "NSExtensionPointIdentifier": "com.apple.widgetkit-extension"
//                                                        ],
//                                                        "Localizations": ["English", "tr", "es-419"],
//                                                        "CFBundleShortVersionString": "$(STUDY_VERSION)",
//                                                        "CFBundleVersion": "$(STUDY_BUNDLE_VERSION)"
//                                                       ]),
//                                                       dependencies: [.reference(.nutritionalPlanCore)],
//                                                       resourcesTypes: [.xcassets, .strings, .xcprivacy],
//                                                       addtionalResources: [.glob(pattern: .relativeToAppResources("Assets/Study/ColorsAssets.xcassets"))],
//                                                       settings: Settings.app(for: "PaQWidget"))
//}
//
//public extension Reference {
//    // The widget project path should be the same one as the app your'e planning to use it
//    static let studyPaqWidget = Reference(projectPath: .studyAppPath, target: .paqWidgetModule)
//}

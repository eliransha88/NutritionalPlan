//
//  Target+UIComponents.swift
//  ProjectDescriptionHelpers
//
//  Created by Eliran Sharabi on 10/08/2022.
//

import ProjectDescription

public extension Target {
    private static let targetName = "UIComponents"
    
    static let uiComponentsModule: Target = .targetModule(targetName: targetName,
                                                          dependencies: [
                                                            .reference(.utilities),
                                                            .external(name: "SFSafeSymbols")
                                                          ],
                                                          resourcesTypes: [.strings, .xcassets],
                                                          addtionalResources: [

                                                          ])
    static let uiComponentsExampleApp: Target = .targetModule(targetType: .exampleApp,
                                                              targetName: targetName,
                                                              infoPlist: .file(path: .relativeToManifest("\(targetName)ExampleApp/Info.plist")),
                                                              resourcesTypes: [.xcassets],
                                                              settings: .settings(defaultSettings: DefaultSettings.recommended))
}

public extension Path {
    static let uiComponentsProjectPath: Path = .relativeToModules(Target.uiComponentsModule.name)
}

public extension Reference {
    nonisolated(unsafe) static let uiComponents = Reference(projectPath: .uiComponentsProjectPath, target: .uiComponentsModule)
}

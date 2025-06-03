//
//  Target+SystemTestsSDK.swift
//  ProjectDescriptionHelpers
//
//  Created by Eliran Sharabi on 25/08/2022.
//

import ProjectDescription

public extension Target {
    private static let targetName = "SystemTestsSDK"
    private static let parentFolder = "NutritionalPlan"
    
    static let systemTestsSDKModule: Target = .targetModule(targetName: targetName,
                                                      scripts: [.emptyKifScreenshotsFolder()],
                                                      dependencies: [
                                                        .external(name: "KIF")
                                                        ],
                                                      resourcesTypes: [],
                                                      addtionalResources: [
                                                        
                                                      ])
}

public extension Path {
    static let systemTestsSDKProjectPath: Path = .relativeToModules(Target.systemTestsSDKModule.name)
}

public extension Reference {
    nonisolated(unsafe) static let systemTestsSDK = Reference(projectPath: .systemTestsSDKProjectPath, target: .systemTestsSDKModule)
}

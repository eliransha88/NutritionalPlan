//
//  Target+NutritionalPlanCore.swift
//  ProjectDescriptionHelpers
//
//  Created by Eliran Sharabi on 10/08/2022.
//

import ProjectDescription

public extension Target {
    private static let targetName = "NutritionalPlanCore"
    static let nutritionalPlanCoreModule: Target = .targetModule(targetName: targetName,
                                                       dependencies: [
                                                        .reference(.uiComponents),
                                                        .reference(.utilities),
                                                        .external(name: "Swinject")
                                                       ],
                                                                 resourcesTypes: [.json, .strings],
                                                       withUmrella: true)
    
    static let nutritionalPlanCoreUnitTests: Target = .targetModule(targetType: .unitTests,
                                                          targetName: targetName,
                                                          scripts: [
                                                            .cuckoo(
                                                                moduleName: targetName,
                                                                moduleFilePaths: [

                                                                ]
                                                            )
                                                          ])
}

public extension Path {
    static let nutritionalPlanCoreProjectPath: Path = .relativeToModules(Target.nutritionalPlanCoreModule.name)
}

public extension Reference {
    nonisolated(unsafe) static let nutritionalPlanCore = Reference(projectPath: .nutritionalPlanCoreProjectPath,
                                               target: .nutritionalPlanCoreModule)
    nonisolated(unsafe) static let nutritionalPlanCoreUnitTests = Reference(projectPath: .nutritionalPlanCoreProjectPath,
                                                        target: .nutritionalPlanCoreUnitTests)
}

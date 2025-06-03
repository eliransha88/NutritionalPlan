//
//  Target+NutritionalPlanHome.swift
//  ProjectDescriptionHelpers
//
//  Created by Gal Orlanczyk on 20/05/2022.
//

import ProjectDescription

public extension Target {
    private static let nutritionalPlanHomeTargetName = "NutritionalPlanHome"
    private static let parentFolder = "NutritionalPlan"
    
    static let nutritionalPlanHomeModule: Target = .targetModule(targetName: nutritionalPlanHomeTargetName,
                                                       parentFolder: parentFolder,
                                                                 dependencies: [
                                                                    .reference(.nutritionalPlanCore)
                                                       ],
                                                       resourcesTypes: [.json, .strings, .xcassets])
    static let nutritionalPlanHomeUnitTests: Target = .targetModule(targetType: .unitTests,
                                                          targetName: nutritionalPlanHomeTargetName,
                                                          parentFolder: parentFolder,
                                                          scripts: [.cuckoo(
                                                            moduleName: nutritionalPlanHomeTargetName,
                                                            parentFolder: parentFolder,
                                                            moduleFilePaths: [

                                                            ]
                                                          )],
                                                          dependencies: [
                                                            
                                                          ])
    
    static let nutritionalPlanSystemTests: Target = .targetModule(targetType: .systemTests,
                                                        targetName: parentFolder,
                                                        dependencies: [.reference(.systemTestsSDK),
                                                                       .reference(.nutritionalPlanHome),
                                                                       .reference(.nutritionalPlanApp),
                                                                       .xctest],
                                                        resourcesTypes: [])
}

public extension Path {
    static let nutritionalPlanProjectPath: Path = .relativeToModules("NutritionalPlan")
}

public extension Reference {
    nonisolated(unsafe) static let nutritionalPlanHome = Reference(projectPath: .nutritionalPlanProjectPath, target: .nutritionalPlanHomeModule)
    nonisolated(unsafe) static let nutritionalPlanHomeUnitTests = Reference(projectPath: .nutritionalPlanProjectPath, target: .nutritionalPlanHomeUnitTests)
}

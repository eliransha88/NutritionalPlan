//
//  Target+Utilities.swift
//  ProjectDescriptionHelpers
//
//  Created by Eliran Sharabi on 10/08/2022.
//

import ProjectDescription

public extension Target {
    private static let targetName = "Utilities"
    static let utilitiesModule: Target = .targetModule(targetName: targetName,
                                                            dependencies: [
                                                            ])
    static let utilitiesUnitTests: Target = .targetModule(targetType: .unitTests,
                                                               targetName: targetName,
                                                               scripts: [.cuckoo(
                                                                moduleName: targetName,
                                                                moduleFilePaths: [

                                                                ]
                                                               )])
}

public extension Path {
    static let utilitiesProjectPath: Path = .relativeToModules(Target.utilitiesModule.name)
}

public extension Reference {
    nonisolated(unsafe) static let utilities = Reference(projectPath: .utilitiesProjectPath, target: .utilitiesModule)
    nonisolated(unsafe) static let utilitiesUnitTests = Reference(projectPath: .utilitiesProjectPath, target: .utilitiesUnitTests)
}

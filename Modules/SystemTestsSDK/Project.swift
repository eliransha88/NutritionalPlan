//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Eliran Sharabi on 25/08/2022.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.newProject(
    name: Target.systemTestsSDKModule.name,
    targets: [
        .systemTestsSDKModule
    ]
)

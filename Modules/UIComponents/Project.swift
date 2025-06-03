//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Eliran Sharabi on 10/08/2022.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.newProject(
    name: Target.uiComponentsModule.name,
    targets: [
        .uiComponentsModule,
        .uiComponentsExampleApp
    ]
)

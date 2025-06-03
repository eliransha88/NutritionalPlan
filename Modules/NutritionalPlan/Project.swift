//
//  Project.swift
//  Manifests
//
//  Created by Gal Orlanczyk on 15/05/2022.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.newProject(
    name: "NutritionalPlanHome",
    targets: [
        .nutritionalPlanHomeModule,
        .nutritionalPlanHomeUnitTests
    ]
)

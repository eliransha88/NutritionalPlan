//
//  Project.swift
//  Manifests
//
//  Created by Eliran Sharabi on 27/05/2025.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.newAppProject(
    name: "NutritionalPlan",
    targets: [
        .nutritionalPlanAppTarget,
        .nutritionalPlanSystemTests
    ]
)

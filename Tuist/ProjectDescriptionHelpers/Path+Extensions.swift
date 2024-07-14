//
//  Path+Extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by Eliran Sharabi on 09/07/2024.
//

import ProjectDescription

public extension Path {
    // Path relative to Modules folder under root folder
    static func relativeToResources(_ pathString: String) -> ProjectDescription.Path {
        return .relativeToRoot("NutritionalPlan/Resources/\(pathString)")
    }
    
    // Path relative to Apps folder under root folder
    static func relativeToSource(_ pathString: String) -> ProjectDescription.Path {
        return .relativeToRoot("NutritionalPlan/Source/\(pathString)")
    }
}

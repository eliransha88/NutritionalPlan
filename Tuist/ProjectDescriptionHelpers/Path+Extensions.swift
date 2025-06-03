//
//  Path+Extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by Eliran Sharabi on 07/05/2022.
//

import ProjectDescription

public extension Path {
    // Path relative to Modules folder under root folder
    static func relativeToModules(_ pathString: String) -> ProjectDescription.Path {
        return .relativeToRoot("Modules/\(pathString)")
    }
    
    // Path relative to Apps folder under root folder
    static func relativeToApps(_ pathString: String) -> ProjectDescription.Path {
        return .relativeToRoot("Apps/\(pathString)")
    }
    
    // Path relative to AppResources folder under root folder
    static func relativeToAppResources(_ pathString: String) -> ProjectDescription.Path {
        return .relativeToRoot("AppResources/\(pathString)")
    }
}

public class PathHelper {
    
    // Get target path for target type
    // Ex, 
    static func getTargetPath(targetType: TargetType, moduleName: String, parentFolder: String?) -> String {
        var sourcesPath = "\(moduleName)/\(moduleName)\(targetType.postfixPathValue)"
        appendParentFolderIfNeeded(path: &sourcesPath, parentFolder: parentFolder)
        return sourcesPath
    }
    
    static func getSourcesPath(targetType: TargetType, moduleName: String, parentFolder: String?) -> String {
        var sourcesPath = "\(moduleName)/\(moduleName)\(targetType.postfixPathValue)/Sources"
        appendParentFolderIfNeeded(path: &sourcesPath, parentFolder: parentFolder)
        return sourcesPath
    }
    
    private static func appendParentFolderIfNeeded(path: inout String, parentFolder: String?) {
        if let parentFolder = parentFolder {
            path = "\(parentFolder)/\(path)"
        }
    }
}

//
//  Project+ModuleTarget.swift
//  ProjectDescriptionHelpers
//
//  Created by Eliran Sharabi on 05/05/2022.
//

import ProjectDescription

public enum TargetType {
    case module
    case unitTests
    case systemTests
    case appWidget
    case appExtension
    case testUtils
    case debugModule
    case exampleApp
    
    var postfixPathValue: String {
        switch self {
        case .module, .appExtension: return ""
        case .unitTests: return "Tests"
        case .systemTests: return "SystemTests"
        case .appWidget: return "Widget"
        case .testUtils: return "TestUtils"
        case .debugModule: return "Debug"
        case .exampleApp: return "ExampleApp"
        }
    }
    
    var productType: Product {
        switch self {
        case .module, .testUtils, .debugModule:
            return .staticFramework
        case .unitTests, .systemTests:
            return .unitTests
        case .appWidget, .appExtension:
            return .appExtension
        case .exampleApp:
            return .app
        }
    }
}

// MARK: - Helpers
public extension Target {
    /// Used to define a generic target module
    /// - Parameters:
    ///   - targetType: TargetType
    ///   - targetName: The target name - ex, NutritionalPlanCore
    ///   - parentFolder: Optional - in cae the targets folder resides inside a parent folder you can add it here - ex, Prep/PrepShared
    ///   - bundleId:Optional - custom bundle id, default is "com.nutritionalPlan.\(targetName)"
    ///   - infoPlist: Optional - if a specific infoPlist is needed
    ///   - scripts: Scripts if needed - ex. cuckoo
    ///   - dependencies: If external/ internal dependencies are needed
    ///   - resourcesTypes: Which resources types does this module has. ex. xib, json, strings
    ///   - addtionalResources: Additional resources other than the types, ex, "katex folder"
    ///   - withConfigFile: Does this module has a config file
    ///   - withUmrella:Should try and get umbrealla file for this module
    ///   - settings: Specific settings if needed, default based on the target type
    static func targetModule(
        targetType: TargetType = .module,
        targetName: String,
        parentFolder: String? = nil,
        bundleId: String? = nil,
        deploymentTargets: ProjectDescription.DeploymentTargets? = .default,
        infoPlist: InfoPlist = .default,
        scripts: [ProjectDescription.TargetScript] = [],
        dependencies: [ProjectDescription.TargetDependency] = [],
        resourcesTypes: [ResourceType] = [],
        addtionalResources: [ResourceFileElement] = [],
        additionalFiles: [FileElement] = [],
        withUmrella: Bool = false,
        settings: Settings = .module
    ) -> Target {
        let moduleDirPath = PathHelper.getTargetPath(targetType: targetType, moduleName: targetName, parentFolder: parentFolder)
        let sourcesDirPath = PathHelper.getSourcesPath(targetType: targetType, moduleName: targetName, parentFolder: parentFolder)
        var settings: Settings = settings
        var dependenciesList = dependencies

        let umbreallaPath = Path.relativeToModules("\(sourcesDirPath)/\(targetName).h")
        
        // Add extra arguments based on target types
        switch targetType {
        case .unitTests, .testUtils:
            // We add Cuckoo as default for all the unit tests targets
            dependenciesList.append(.external(name: "Cuckoo"))
            // We add the main target module as a dependency
            dependenciesList.append(.target(name: targetName))
            settings = .empty
        case .debugModule, .exampleApp:
            // We add the main target module as a dependency
            dependenciesList.append(.target(name: targetName))
        case .systemTests:
            settings = .systemTests(targetName: targetName)
        default: break
        }
        
        return baseTarget(
            name: "\(targetName)\(targetType.postfixPathValue)",
            product: targetType.productType,
            bundleId: bundleId,
            deploymentTargets: deploymentTargets,
            infoPlist: infoPlist,
            sources: sources(from: moduleDirPath),
            resources: resources(from: moduleDirPath,
                                 types: Set(resourcesTypes),
                                 addtionalResources: addtionalResources),
            headers: publicHeaders(from: moduleDirPath, umbrella: withUmrella ? umbreallaPath : nil),
            scripts: scripts,
            dependencies: dependenciesList,
            additionalFiles: additionalFiles,
            settings: settings
        )
    }
    
    // MARK: Private functions
    private static func baseTarget(
        name: String,
        product: Product,
        bundleId: String? = nil,
        deploymentTargets: ProjectDescription.DeploymentTargets?,
        infoPlist: InfoPlist = .default,
        sources: ProjectDescription.SourceFilesList? = nil,
        resources: ProjectDescription.ResourceFileElements? = nil,
        headers: ProjectDescription.Headers? = nil,
        scripts: [ProjectDescription.TargetScript] = [],
        dependencies: [ProjectDescription.TargetDependency] = [],
        additionalFiles: [FileElement] = [],
        settings: Settings = .settings()
    ) -> Target {
        return Target.target(
            name: "\(name)",
            destinations: .iOS,
            product: product,
            bundleId: bundleId ?? "com.nutritionalPlan.\(name)",
            deploymentTargets: deploymentTargets,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            headers: headers,
            scripts: scripts,
            dependencies: dependencies,
            settings: settings,
            additionalFiles: additionalFiles
        )
    }
    
    enum SourceType: CaseIterable {
        case swift
        case m
        
        func sourceFileGlob(from basePath: String, excluding: [Path] = []) -> SourceFileGlob {
            switch self {
            case .swift:
                return SourceFileGlob.glob(.relativeToModules("\(basePath)/**/*.swift"), excluding: excluding)
            case .m:
                return SourceFileGlob.glob(.relativeToModules("\(basePath)/**/*.m"), excluding: excluding)
            }
        }
    }
    
    private static func sources(from basePath: String,
                        types: Set<SourceType> = [.swift, .m],
                        excluding: [Path] = []) -> SourceFilesList {
        
        var globs: [SourceFileGlob] = []
        for sourceType in types {
            globs.append(sourceType.sourceFileGlob(from: basePath, excluding: excluding))
        }
        return SourceFilesList.sourceFilesList(globs: globs)
    }
    
    enum ResourceType: String, CaseIterable {
        case xib
        case storyboard
        case json
        case strings
        case stringsdict
        case otf
        case xcassets
        case html
        case css
        case xcdatamodeld
        case plist
        case enc
        case wav
        case jpg
        case ttf
        case graphql
        case mp4
        case xcprivacy
        
        func resourceFileElement(from basePath: String, excluding: [Path] = []) -> ResourceFileElement {
            return ResourceFileElement.glob(pattern: .relativeToModules("\(basePath)/**/*.\(self.rawValue)"), excluding: excluding)
        }
    }
    
    private static func resources(from basePath: String,
                          types: Set<ResourceType>,
                          excluding: [Path] = [],
                          addtionalResources: [ResourceFileElement] = []) -> ResourceFileElements {
        
        var resources: [ResourceFileElement] = addtionalResources
        for resourceType in types {
            resources.append(resourceType.resourceFileElement(from: basePath, excluding: excluding))
        }
        
        return ResourceFileElements.resources(resources)
    }
    
    private static func publicHeaders(from path: String, excluding: [Path] = [], umbrella: Path? = nil) -> Headers {
        return publicHeaders(
            .list([
                .glob(.relativeToModules("\(path)/**/*.h"), excluding: excluding)
            ]), umbrella: umbrella
        )
    }
    
    private static func publicHeaders(_ headers: FileList? = nil, umbrella: Path? = nil) -> Headers {
        if let umbrella = umbrella, let headers = headers {
            return .allHeaders(from: headers, umbrella: umbrella)
        }
        return .headers(public: headers)
    }
}

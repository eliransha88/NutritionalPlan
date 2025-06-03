//
//  MainTargets.swift
//  ProjectDescriptionHelpers
//
//  Created by Eliran Sharabi on 03/05/2022.
//

import ProjectDescription

public extension Target {
    /// Used to define a generic target for app
    /// - Parameters:
    ///   - name: App name
    ///   - infoPlist: Optional - if a specific infoPlist is needed
    ///   - sources: Path for additional sources for the app target, there's a default
    ///   - resources: Path for additional sources for the app target
    ///   - dependencies: Which dependencies does this app needs
    ///   - settings: Specific seettings if needed, default: Settings.app
    ///   - additionalFiles: Additional filed if needed
    static func app(name: String,
                    infoPlist: ProjectDescription.InfoPlist? = nil,
                    sources: ProjectDescription.SourceFilesList? = nil,
                    resources: ProjectDescription.ResourceFileElements? = nil,
                    dependencies: [ProjectDescription.TargetDependency] = [],
                    debugDependencies: [ProjectDescription.TargetDependency] = [],
                    settings: ProjectDescription.Settings? = nil,
                    additionalFiles: [ProjectDescription.FileElement] = []) -> Target {
        var dependencies = dependencies

        // Add debug dependencies based on "TUIST_IS_DEBUG" env variable
        // https://docs.tuist.io/guides/environment
        let isDebug = Environment.isDebug.getBoolean(default: true)
        if isDebug {
            dependencies.append(contentsOf: debugDependencies)
        }
                
        // Merge received sources with default ones
        var sourceGlobs = sources?.globs ?? []
        let defaultSources: SourceFilesList = .paths([
            .relativeToApps("\(name)/Sources/**")
        ])
        sourceGlobs.append(contentsOf: defaultSources.globs)
        let targetSources: SourceFilesList = SourceFilesList.sourceFilesList(globs: sourceGlobs)
        
        // Merge received resources with default ones
        var resourceFiles = resources?.resources ?? []
        let defaultResources: [ResourceFileElement] = [
            .glob(pattern: .relativeToAppResources("InfoPlist/\(name)/PrivacyInfo.xcprivacy")),
            .glob(pattern: .relativeToAppResources("Assets/\(name)/Assets.xcassets"))
        ]
        resourceFiles.append(contentsOf: defaultResources)
        let targetResources: ResourceFileElements = ResourceFileElements.resources(resourceFiles)
        
        // Merge received additional files with default ones
        let defaultAdditionalFiles: [ProjectDescription.FileElement] = [
            .glob(pattern: .relativeToAppResources("xcconfig/\(name)ProjectVersions.xcconfig")),
            .glob(pattern: .relativeToAppResources("Entitlements/\(name)/\(name).entitlements")),
            .glob(pattern: .relativeToAppResources("Entitlements/\(name)/\(name)Release.entitlements"))
        ]
        
        var additionalFiles: [ProjectDescription.FileElement] = additionalFiles
        additionalFiles.append(contentsOf: defaultAdditionalFiles)
        
        let scripts: [TargetScript] = [
            
        ]
        
        return Target.target(
            name: "\(name)",
            destinations: .iOS,
            product: .app,
            bundleId: "${BUNDLE_ID}",
            deploymentTargets: .default,
            infoPlist: infoPlist,
            sources: targetSources,
            resources: targetResources,
            scripts: scripts,
            dependencies: dependencies,
            settings: settings ?? Settings.app(for: name),
            additionalFiles: additionalFiles
        )
    }
}

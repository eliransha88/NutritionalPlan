//
//  Reference.swift
//  ProjectDescriptionHelpers
//
//  Created by Eliran Sharabi on 27/05/2022.
//

import ProjectDescription

/// provides reference to all targets information
public struct Reference {
    
    public let schemeName: String
    public let projectPath: Path
    public let target: Target
    
    init(schemeName: String? = nil, projectPath: Path, target: Target) {
        self.schemeName = schemeName ?? target.name
        self.projectPath = projectPath
        self.target = target
    }
    
    public var targetName: String {
        self.target.name
    }
    
    public var targetReference: TargetReference {
        return TargetReference.project(path: self.projectPath, target: self.targetName)
    }
    
    public var targetDependency: TargetDependency {
        return TargetDependency.project(target: self.targetName, path: self.projectPath)
    }
    
    public var testableTarget: TestableTarget {
        return TestableTarget.testableTarget(target: self.targetReference)
    }
}

public extension String {
    
    static func target(_ target: Target) -> String {
        return target.name
    }
}

public extension TargetReference {
    
    init(reference: Reference) {
        self = reference.targetReference
    }
    
    static func reference(_ reference: Reference) -> TargetReference {
        return reference.targetReference
    }
}

public extension TargetDependency {
    
    init(reference: Reference) {
        self = reference.targetDependency
    }
    
    static func reference(_ reference: Reference) -> TargetDependency {
        return reference.targetDependency
    }
}

public extension TestableTarget {
    
    init(reference: Reference) {
        self = reference.testableTarget
    }
    
    static func reference(_ reference: Reference) -> TestableTarget {
        return reference.testableTarget
    }
}

extension Array where Element == TestableTarget {
    
    static func references(_ references: [Reference]) -> [Element] {
        return references.map { $0.testableTarget }
    }
}

extension Array where Element == TargetDependency {
    
    static func references(_ references: [Reference]) -> [Element] {
        return references.map { $0.targetDependency }
    }
}

extension Array where Element == TargetReference {
    
    static func references(_ references: [Reference]) -> [Element] {
        return references.map { $0.targetReference }
    }
}

import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/
public extension Project {
    
    static func newAppProject(name: String,
                                 targets: [Target],
                                 schemes: [Scheme] = []) -> Project {
        return Project(
            name: name,
            organizationName: "NutritionalPlan",
            options: .options(developmentRegion: "en"),
            settings: .appProject,
            targets: targets,
            schemes: schemes,
            // Local templates can be located under ResourceSynthesizers folder
            resourceSynthesizers: [.strings(), .assets(), .fonts()]
        )
    }
    
    static func newProject(name: String,
                           targets: [Target],
                           packages: [Package] = []) -> Project {
        return Project(
            name: name,
            options: .options(developmentRegion: "en"),
            packages: packages,
            settings: .empty,
            targets: targets
        )
    }
}

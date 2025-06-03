import ProjectDescription

let config = Config(
    plugins: [
        .local(path: .relativeToRoot("Tuist/ProjectDescriptionHelpers"))
    ],
    project: .tuist(
        swiftVersion: "6.0.2"
    )
)

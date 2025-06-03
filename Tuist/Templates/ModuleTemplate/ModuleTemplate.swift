import ProjectDescription

let nameAttribute: Template.Attribute = .required("name")
let propertyName: Template.Attribute = .required("lcname")

let template = Template(
    description: "Template to create module",
    attributes: [
        nameAttribute,
        propertyName
    ],
    items: [
        // Add files to Modules folder (both Sources sand Tests)
        .file(path: "Modules/\(nameAttribute)/\(nameAttribute)Tests/\(nameAttribute)Tests.swift",
              templatePath: "./TemplateFiles/Tests.stencil"),
        // Adds the relevant file to Target+Modules which defines both module and unit tests module.
        .file(
            path: "Tuist/ProjectDescriptionHelpers/Target+Modules/Target+\(nameAttribute).swift",
            templatePath: "./TemplateFiles/Target+Module.stencil"
        ),
        // Add a project file that containts the module and the unit tests.
        .file(
            path: "Modules/\(nameAttribute)/Project.swift",
            templatePath: "./TemplateFiles/Project.stencil"
        )
    ]
)

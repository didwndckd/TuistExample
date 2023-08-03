//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by yjc on 2023/08/03.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.create(
    name: "UserInterfaceKit",
    product: .framework,
    dependencies: [
        .project(target: "Home", path: .relativeToRoot("Projects/UserInterface/Home")),
    ],
    resources: ["Resources/**"]
)

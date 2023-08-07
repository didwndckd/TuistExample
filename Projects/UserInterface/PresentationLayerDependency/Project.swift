//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by yjc on 2023/08/07.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.create(
    name: "PresentationLayerDependency",
    product: .framework,
    dependencies: [
        .project(
            target: "ResourceKit",
            path: .relativeToRoot("Projects/ResourceKit")
        )
    ]
)

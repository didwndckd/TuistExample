//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by yjc on 2023/08/07.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.create(
    name: "DataLayerDependency",
    product: .framework,
    dependencies: [
        .project(
            target: "DomainLayerDependency",
            path: .relativeToRoot("Projects/UserInterface/DomainLayerDependency")
        )
    ]
)

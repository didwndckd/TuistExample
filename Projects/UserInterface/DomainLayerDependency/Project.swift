//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by yjc on 2023/08/07.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.create(
    name: "DomainLayerDependency",
    product: .framework,
    dependencies: [
        .project(
            target: "ThirdPartyLibraryKit",
            path: .relativeToRoot("Projects/ThirdPartyLibraryKit")
        )
    ]
)

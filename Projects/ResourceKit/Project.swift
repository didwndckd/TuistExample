//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by yjc on 2023/08/07.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.create(
    name: "ResourceKit",
    product: .framework,
    sources: ["Sources/**"],
    resources: ["Resources/**"]
)

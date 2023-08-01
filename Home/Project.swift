//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by yjc on 2023/08/01.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.createCleanArchitecture(
    name: "Home",
    product: .staticFramework,
    resources: ["Resources/**"]
)

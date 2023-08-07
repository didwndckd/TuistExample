//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by yjc on 2023/08/07.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.create(
    name: "ThirdPartyLibraryKit",
    product: .framework,
    packages: [
    ],
    dependencies: [
        .external(name: "SnapKit"),
        .external(name: "Moya")
    ]
)

//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by yjc on 2023/08/01.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.create(
    name: "TuistExampleApp",
    product: .app,
    dependencies: [
//        .project(target: "Common", path: .relativeToRoot("Common")),
        .project(
            target: "UserInterfaceKit",
            path: .relativeToRoot("Projects/UserInterface/UserInterfaceKit")
        ),
//        .project(target: "Search", path: .relativeToRoot("Search"))
    ],
    resources: ["Resources/**"],
//    infoPlist: .extendingDefault(with: [ // 코드로 생성
//        "UIMainStoryboardFile": "",
//        "UILaunchStoryboardName": "LaunchScreen",
//        "ENABLE_TESTS": .boolean(true)
//    ])
    infoPlist: .file(path: "Support/Info.plist")
)

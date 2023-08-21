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
        .remote(
            url: "https://github.com/firebase/firebase-ios-sdk",
            requirement: .upToNextMajor(from: "9.0.0")
        )
    ],
    dependencies: [
        .external(name: "SnapKit"),
        .external(name: "Moya"),
        .package(product: "FirebaseAnalytics"),
        .package(product: "FirebaseCrashlytics")
    ],
    settings: .settings(
        debug: ["OTHER_LDFLAGS": "-ObjC"],
        release: ["OTHER_LDFLAGS": "-ObjC"]
    )
)

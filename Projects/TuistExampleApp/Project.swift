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
    scripts: [
        .post(
            path: .relativeToRoot("Scripts/RunScript_FirebaseCrashlytics.sh"),
            name: "RunScript(FirebaseCrashlytics)",
            inputPaths: [
                "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}",
                "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${PRODUCT_NAME}",
                "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Info.plist",
                "$(BUILT_PRODUCTS_DIR)/$(UNLOCALIZED_RESOURCES_FOLDER_PATH)/GoogleService-Info.plist",
                "$(BUILT_PRODUCTS_DIR)/$(EXECUTABLE_PATH)"
            ],
            basedOnDependencyAnalysis: false
        )
    ],
    dependencies: [
        .project(
            target: "UserInterfaceKit",
            path: .relativeToRoot("Projects/UserInterface/UserInterfaceKit")
        ),
        .project(
            target: "ThirdPartyLibraryKit",
            path: .relativeToRoot("Projects/ThirdPartyLibraryKit")
        )
    ],
    resources: ["Resources/**", "Support/GoogleService-Info.plist"],
    infoPlist: .file(path: "Support/Info.plist"),
    settings: .settings(
        configurations: [
            .debug(name: .debug, xcconfig: "./xcconfig/TuistExampleApp.xcconfig"),
            .release(name: .release, xcconfig: "./xcconfig/TuistExampleApp.xcconfig")
        ]
    )
)

//
//  SceneDelegate.swift
//  ProjectDescriptionHelpers
//
//  Created by yjc on 2023/08/01.
//

import UIKit
import SwiftUI
import UserInterfaceKit
import Home

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let view = Home.module()
        let viewController = UIHostingController(rootView: view)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        self.window = window
        print(UserInterfaceKit().name)
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

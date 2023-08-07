//
//  SceneDelegate.swift
//  ProjectDescriptionHelpers
//
//  Created by yjc on 2023/08/01.
//

import UIKit
import SwiftUI
import HomePresentation
import HomeDomain
import HomeData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let repository = RemoteHomeRepository()
        let useCase = DefaultHomeUseCase(repository: repository)
        let viewModel = HomeViewModel(useCase: useCase)
        let view = HomeView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

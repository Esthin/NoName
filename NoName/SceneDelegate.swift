//
//  SceneDelegate.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        // TODO: Remove factory. DI Container
        window?.rootViewController = UINavigationController(rootViewController: UserModuleFactory()
            .buildUserList())
        window?.makeKeyAndVisible()
    }
    
}


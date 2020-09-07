//
//  SceneDelegate.swift
//  Main
//
//  Created by André Haas on 30/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import UIKit
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let nav = NavigationController()
        let httpClient = makeAlamofireAdapter()
        let authentiction = makeRemoteAuthentication(httpClient: httpClient)
        let loginController = makeLoginController(authentication: authentiction)
        nav.setRootViewController(loginController)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

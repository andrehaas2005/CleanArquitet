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

        let httpClient = makeAlamofireAdapter()
        let addAccount = makeRemoteAddAccount(httpClient: httpClient)
        let signUpController = makeSignUpController(addAccount: addAccount)
        let nav = NavigationController(rootViewController: signUpController)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

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


    private let signUpFactory: () -> SignUpViewController = {
        let alamofireAdapter = makeAlamofireAdapter()
        let addAccount = makeRemoteAddAccount(httpClient: alamofireAdapter)
        return makeSignUpController(addAccount: addAccount)
    }

    private let loginFactory: () -> LoginViewController = {
        let alamofireAdapter = makeAlamofireAdapter()
        let authentiction = makeRemoteAuthentication(httpClient: alamofireAdapter)
        return makeLoginController(authentication: authentiction)
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let nav = NavigationController()
        let welcomeRouter = WelcomeRouter(nav: nav, loginFactory: loginFactory, signUpFactory: signUpFactory)
        let welcomeViewController = WelcomeViewController.instantiate()
        welcomeViewController.login = welcomeRouter.goToLogin
        welcomeViewController.signUp = welcomeRouter.goToSignUp

        nav.setRootViewController(welcomeViewController)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

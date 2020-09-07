//
//  WelcomeRouter.swift
//  UI
//
//  Created by André Haas on 07/09/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

public final class WelcomeRouter {

    private let nav: NavigationController
    private let loginFactory: ()-> LoginViewController
    private let signUpFactory: ()-> SignUpViewController
    public init(nav: NavigationController,
                loginFactory: @escaping ()-> LoginViewController,
                signUpFactory: @escaping ()-> SignUpViewController) {
        self.nav = nav
        self.loginFactory = loginFactory
        self.signUpFactory = signUpFactory
    }
    public func goToLogin(){
        nav.pushViewController(loginFactory())
    }

    public func goToSignUp(){
        nav.pushViewController(signUpFactory())
    }
}


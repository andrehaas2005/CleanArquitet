//
//  WelcomeRouterTests.swift
//  UITests
//
//  Created by André Haas on 07/09/20.
//  Copyright © 2020 André Haas. All rights reserved.
//
import UIKit
import XCTest
import UI

public final class WelcomeRouter {

    private let nav: NavigationController
    private let loginFactory: ()-> LoginViewController
    public init(nav: NavigationController, loginFactory: @escaping ()-> LoginViewController) {
        self.nav = nav
        self.loginFactory = loginFactory
    }
    public func goToLogin(){
        nav.pushViewController(loginFactory())
    }
}

class WelcomeRouterTests: XCTestCase {


    func test_go_tologin_calls_nav_if_correct_vc()  {
        let loginFactorySpy = LoginFactorySpy()
        let nav = NavigationController()
        let sut = WelcomeRouter(nav: nav, loginFactory: loginFactorySpy.makeLogin)
        sut.goToLogin()
        XCTAssertEqual(nav.viewControllers.count, 1)
        XCTAssertTrue(nav.viewControllers.first is LoginViewController)
    }

    class LoginFactorySpy {
        func makeLogin() -> LoginViewController {
            return LoginViewController.instantiate()
        }
    }

}

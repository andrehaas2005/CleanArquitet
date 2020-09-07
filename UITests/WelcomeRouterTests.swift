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

class WelcomeRouterTests: XCTestCase {


    func test_goToLogin_calls_nav_if_correct_vc()  {
        let (sut, nav) = makeSut()
        sut.goToLogin()
        XCTAssertEqual(nav.viewControllers.count, 1)
        XCTAssertTrue(nav.viewControllers.first is LoginViewController)
    }

    func test_goToSignUp_calls_nav_if_correct_vc()  {
        let (sut, nav) = makeSut()
        sut.goToSignUp()
        XCTAssertEqual(nav.viewControllers.count, 1)
        XCTAssertTrue(nav.viewControllers.first is SignUpViewController)
    }


}
extension WelcomeRouterTests {
    func makeSut() -> (sut: WelcomeRouter, nav: NavigationController){
        let loginFactorySpy = LoginFactorySpy()
        let signUpFactorySpy = SignUpFactorySpy()
        let nav = NavigationController()
        let sut = WelcomeRouter(nav: nav, loginFactory: loginFactorySpy.makeLogin, signUpFactory: signUpFactorySpy.makeSignUp)
        return (sut, nav)
    }
}

extension WelcomeRouterTests {
    class LoginFactorySpy {
        func makeLogin() -> LoginViewController {
            return LoginViewController.instantiate()
        }
    }

    class SignUpFactorySpy {
        func makeSignUp() -> SignUpViewController {
            return SignUpViewController.instantiate()
        }
    }

}

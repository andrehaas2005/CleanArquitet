//
//  UITests.swift
//  UITests
//
//  Created by André Haas on 06/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import XCTest
import UIKit
import Presentation
@testable import UI

class LoginViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() {
        XCTAssertEqual(makeSuv().loadingIndicator?.isAnimating, false)
    }

    func test_suv_implements_AlertView() {
        XCTAssertNotNil(makeSuv() as AlertView)
    }

    func test_suv_implements_loadview() {
        XCTAssertNotNil(makeSuv() as LoadingView)
    }
    //
    func test_loginButton_calls_login_on_tap() {
        var loginViewModel: LoginRequest?

        let sut = makeSuv(loginSpy: { loginViewModel = $0 })
        let email = sut.emailTextField?.text
        let password = sut.passwordTextField?.text
        
        sut.loginButton?.simulateTap()
        XCTAssertEqual(loginViewModel, LoginRequest(email: email, password: password))
    }
}

extension LoginViewControllerTests {
    func makeSuv(loginSpy: ((LoginRequest)->Void)? = nil, file: StaticString = #file, line: UInt = #line) -> LoginViewController {

        let sut = LoginViewController.instantiate()
        sut.login = loginSpy
        sut.loadViewIfNeeded()
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}

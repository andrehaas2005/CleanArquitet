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

class WelcomeViewControllerTests: XCTestCase {

    func test_loginButton_calls_login_on_tap() {
        let (sut, buttonSpy) = makeSuv()
        sut.loginButton?.simulateTap()
        XCTAssertEqual(buttonSpy.clicks, 1)
    }

    func test_signUpButton_calls_signUp_on_tap() {
        let (sut, buttonSpy) = makeSuv()
        sut.SignUpButton?.simulateTap()
        XCTAssertEqual(buttonSpy.clicks, 1)
    }
}

extension WelcomeViewControllerTests {
    func makeSuv() -> (sut: WelcomeViewController, buttonSpy: ButtonSpy) {
        let buttonSpy = ButtonSpy()
        let sut = WelcomeViewController.instantiate()
        sut.login = buttonSpy.onClick
        sut.signUp = buttonSpy.onClick
        sut.loadViewIfNeeded()
        //        checkMemoryLeak(for: sut, file: file, line: line)
        return (sut, buttonSpy)
    }
    class ButtonSpy {
        var clicks = 0
        func onClick(){
            clicks += 1
        }
    }
}


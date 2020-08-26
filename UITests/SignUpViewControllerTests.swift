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

class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() {
        XCTAssertEqual(makeSuv().loadingIndicator?.isAnimating, false)
    }

    func test_suv_implements_AlertView() {
        XCTAssertNotNil(makeSuv() as LoadingView)
    }

    func test_suv_implements_loadview() {
        XCTAssertNotNil(makeSuv() as AlertView)
    }

    func test_saveButton_calls_signUp_on_tap() {
        var signUpViewModel: SignUpViewModel?
        let sut = makeSuv(signUpSpy: { signUpViewModel = $0 })
        let name = sut.nameTextField?.text
        let email = sut.emailTextField?.text
        let password = sut.passwordTextField?.text
        let passwordConformation = sut.passwordConfirmationTextField?.text

        sut.saveButton?.simulateTap()
        XCTAssertEqual(signUpViewModel, SignUpViewModel(name: name,
                                                        email: email,
                                                        password: password,
                                                        passwordConfirmation: passwordConformation))
    }
}

extension SignUpViewControllerTests {
    func makeSuv(signUpSpy: ((SignUpViewModel)->Void)? = nil) -> SignUpViewController {
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let suv = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        suv.signUp = signUpSpy
        suv.loadViewIfNeeded()
        return suv
    }
}

extension UIControl {
    func simulate(event: Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach({ (action) in
                (target as NSObject).perform(Selector(action))
            })
        }
    }

    func simulateTap(){
        simulate(event: .touchUpInside)
    }
}

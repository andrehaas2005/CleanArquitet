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
        var callsCount = 0
//        let signUpSpy: (SignUpViewModel) -> Void = { _ in
//            callsCount += 1
//        }
        let sut = makeSuv(signUpSpy: { _ in
            callsCount += 1
        })

        sut.saveButton?.simulateTap()
        XCTAssertEqual(callsCount, 1)
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

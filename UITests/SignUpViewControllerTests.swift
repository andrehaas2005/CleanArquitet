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
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let suv = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        suv.loadViewIfNeeded()
        XCTAssertEqual(suv.loadingIndicator?.isAnimating, false)
    }

    func test_suv_implements_loadview() {
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let suv = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        XCTAssertNotNil(suv as? LoadingView)
    }
}

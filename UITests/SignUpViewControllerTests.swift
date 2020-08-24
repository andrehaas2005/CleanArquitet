//
//  UITests.swift
//  UITests
//
//  Created by André Haas on 06/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import XCTest
#if !os(macOS)
import UIKit
#endif

@testable import UI

class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() {
        let sb = UIStoryboard(name: "SignUp", bundle: Bundle(for: SignUpViewController.self))
        let suv = sb.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        suv.loadViewIfNeeded()
        XCTAssertEqual(suv.loadingIndicator?.isAnimating, false)
    }
}

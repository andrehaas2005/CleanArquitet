//
//  SignUpIntegrationTests.swift
//  MainTests
//
//  Created by André Haas on 30/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import XCTest
import Main

class SignUpIntegrationTests: XCTestCase {

    func test_ui_presentention_integration() throws {
     let sut = SignUpComposers.composerControllerWith(addAccount: AddAccountSpy())
        checkMemoryLeak(for: sut)
    }

}

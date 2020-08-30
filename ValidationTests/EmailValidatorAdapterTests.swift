//
//  ValidationTests.swift
//  ValidationTests
//
//  Created by André Haas on 28/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import XCTest
import Presentation
import Validation


class EmailValidatorAdapterTests: XCTestCase {

    func test_invalid_email() throws {
        let suv = makeSut()
        XCTAssertFalse(suv.isValid(email: "rr"))
        XCTAssertFalse(suv.isValid(email: "rr@"))
        XCTAssertFalse(suv.isValid(email: "rr@rr"))
        XCTAssertFalse(suv.isValid(email: "rr@rr."))
        XCTAssertFalse(suv.isValid(email: "@rr.com"))
    }

    func test_valid_email() throws {
        let suv = makeSut()
        XCTAssertTrue(suv.isValid(email: "andre.haas@dextra-sw.com"))
        XCTAssertTrue(suv.isValid(email: "andrehaas2005@gmail.com"))
        XCTAssertTrue(suv.isValid(email: "andrehaaslix@hotmail.com"))
        XCTAssertTrue(suv.isValid(email: "adm@andre.haas.nom.br"))
    }
}

extension EmailValidatorAdapterTests {
    func makeSut() -> EmailValidatorAdapter {
        return EmailValidatorAdapter()
    }
}

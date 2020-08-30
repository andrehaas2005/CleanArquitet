//
//  ValidationTests.swift
//  ValidationTests
//
//  Created by André Haas on 28/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import XCTest
import Presentation

public final class EmailValidatorAdapter: EmailValidator {

    private let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    public func isValid(email: String) -> Bool {
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: pattern)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }


}

class EmailValidatorAdapterTests: XCTestCase {

    func test_invalid_email() throws {
        let suv = EmailValidatorAdapter()
        XCTAssertFalse(suv.isValid(email: "rr"))
        XCTAssertFalse(suv.isValid(email: "rr@"))
        XCTAssertFalse(suv.isValid(email: "rr@rr"))
        XCTAssertFalse(suv.isValid(email: "rr@rr."))
        XCTAssertFalse(suv.isValid(email: "@rr.com"))
    }

    func test_valid_email() throws {
        let suv = EmailValidatorAdapter()
        XCTAssertTrue(suv.isValid(email: "andre.haas@dextra-sw.com"))
        XCTAssertTrue(suv.isValid(email: "andrehaas2005@gmail.com"))
        XCTAssertTrue(suv.isValid(email: "andrehaaslix@hotmail.com"))
        XCTAssertTrue(suv.isValid(email: "adm@andre.haas.nom.br"))
    }
}

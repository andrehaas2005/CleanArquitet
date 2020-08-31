//
//  RequiredFieldValidationTests.swift
//  ValidationTests
//
//  Created by André Haas on 01/09/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import XCTest
import Validation
import Presentation

class RequiredFieldValidationTests: XCTestCase {

    func test_validate_should_return_error_if_field_is_not_provider() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let messageError = sut.validate(data: ["name" : "Andre"])
        XCTAssertEqual(messageError, "O campo Email é obrigatório")
    }

    func test_validate_should_return_error_with_correct_fieldLabel() {
        let sut = makeSut(fieldName: "age", fieldLabel: "Idade")
        let messageError = sut.validate(data: ["name" : "Andre"])
        XCTAssertEqual(messageError, "O campo Idade é obrigatório")
    }

    func test_validate_should_return_nil_if_field_is_provider() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let messageError = sut.validate(data: ["email" : "andrehaas2005@gmail.com"])
        XCTAssertNil(messageError)
    }

    func test_validate_should_return_nil_if_no_data_provider() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email")
        let messageError = sut.validate(data: nil)
        XCTAssertEqual(messageError, "O campo Email é obrigatório")
    }
}

extension RequiredFieldValidationTests {
    func makeSut(fieldName: String, fieldLabel: String, file: StaticString = #file, line: UInt = #line)-> Validation {
        let sut =  RequiredFieldValidation(fieldName: fieldName, fieldLabel: fieldLabel)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}

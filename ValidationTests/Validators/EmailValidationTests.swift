//
//  EmailValidationTests.swift
//  ValidationTests
//
//  Created by André Haas on 02/09/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import XCTest
import Validation
import Presentation

class EmailValidationTests: XCTestCase {

    func test_validate_should_return_error_if_invalid_email_is_provider() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", emailValidator: emailValidatorSpy)
        emailValidatorSpy.simulateInvalidEmail()
        let messageError = sut.validate(data: ["email" : "invalid_email@teste.com"])
        XCTAssertEqual(messageError, "O campo Email é inválido")
    }

    func test_validate_should_return_error_with_correct_fieldLabel() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", fieldLabel: "Email2", emailValidator: emailValidatorSpy)
        emailValidatorSpy.simulateInvalidEmail()
        let messageError = sut.validate(data: ["email" : "invalid_email@teste.com"])
        XCTAssertEqual(messageError, "O campo Email2 é inválido")
    }

    func test_validate_should_return_nil_if_valid_email_is_provider() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", emailValidator: emailValidatorSpy)
        let messageError = sut.validate(data: ["email" : "valid_email@teste.com"])
        XCTAssertNil(messageError)
    }


    func test_validate_should_return_nil_with_not_data_is_provider() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", emailValidator: emailValidatorSpy)
        let messageError = sut.validate(data: nil)
        XCTAssertEqual(messageError, "O campo Email é inválido")
    }
}

extension EmailValidationTests {
    func makeSut(fieldName: String, fieldLabel: String, emailValidator: EmailValidator, file: StaticString = #file, line: UInt = #line)-> Validation {
        let sut =  EmailValidation(fieldName: fieldName, fieldLabel: fieldLabel, emailValidator: emailValidator)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}

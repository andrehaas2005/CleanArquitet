//
//  CompareFieldsValidatorTests.swift
//  ValidationTests
//
//  Created by André Haas on 02/09/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import XCTest
import Validation
import Presentation

class CompareFieldsValidatorTests: XCTestCase {

    func test_validate_should_return_error_if_comparation_fails() {
        let sut = makeSut(fieldName: "password",
                          fieldNameToCompare: "passwordConfirmation",
                          fieldLabel: "Senha")
        let messageError = sut.validate(data: ["password" : "123", "passwordConfirmation" : "1234"])
        XCTAssertEqual(messageError, "O campo Senha é inválido")
    }

    func test_validate_should_return_error_if_with_correct_fieldLabel() {
           let sut = makeSut(fieldName: "password",
                             fieldNameToCompare: "passwordConfirmation",
                             fieldLabel: "Confirmar Senha")
           let messageError = sut.validate(data: ["password" : "123", "passwordConfirmation" : "1234"])
           XCTAssertEqual(messageError, "O campo Confirmar Senha é inválido")
       }


    func test_validate_should_return_nil_if_comparation_succeeds() {
          let sut = makeSut(fieldName: "password",
                                   fieldNameToCompare: "passwordConfirmation",
                                   fieldLabel: "Confirmar Senha")
        let messageError = sut.validate(data: ["password" : "123", "passwordConfirmation" : "123"])
        XCTAssertNil(messageError)
    }

    func test_validate_should_return_nil_if_no_data_provider() {
          let sut = makeSut(fieldName: "password",
                                   fieldNameToCompare: "passwordConfirmation",
                                   fieldLabel: "Senha")
        let messageError = sut.validate(data: nil)
        XCTAssertEqual(messageError, "O campo Senha é inválido")
    }
}

extension CompareFieldsValidatorTests {
    func makeSut(fieldName: String, fieldNameToCompare: String, fieldLabel: String, file: StaticString = #file, line: UInt = #line)-> Validation {
        let sut =  CompareFieldsValidation(fieldName: fieldName,
                                           fieldNameToCompare: fieldNameToCompare,
                                           fieldLabel: fieldLabel)
           checkMemoryLeak(for: sut, file: file, line: line)
           return sut
       }
}

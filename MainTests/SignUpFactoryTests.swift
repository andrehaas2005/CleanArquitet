//
//  SignUpIntegrationTests.swift
//  MainTests
//
//  Created by André Haas on 30/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import XCTest
import Main
import UI
import Validation


class SignUpFactoryTests: XCTestCase {

    func test_backgroud_request_should_complete_on_main_thread() throws {
        let (sut, addAccountSpy) = makeSut()
        sut.loadViewIfNeeded()
        sut.signUp?(makeSignUpViewModel())
        let exp = expectation(description: "waint")
        DispatchQueue.global().async {
            addAccountSpy.completeWithError(.unexpected)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }

    func test_signup_composite_if_correct_validations() {
        let validations = makeSignUpValidations()
        XCTAssertEqual(validations[0] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "name", fieldLabel: "Nome"))
        XCTAssertEqual(validations[1] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"))
        XCTAssertEqual(validations[2] as! EmailValidation, EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorSpy()))
        XCTAssertEqual(validations[3] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"))
        XCTAssertEqual(validations[4] as! RequiredFieldValidation, RequiredFieldValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar Senha"))
        XCTAssertEqual(validations[5] as! CompareFieldsValidation, CompareFieldsValidation(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar Senha"))
    }
}
extension SignUpFactoryTests {
    func makeSut(file: StaticString = #file, line: UInt = #line) -> (sut: SignUpViewController, addAccountSpy: AddAccountSpy) {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSignUpController(addAccount: MainQueueDispatchDecorator(addAccountSpy))
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: addAccountSpy, file: file, line: line)
        return(sut, addAccountSpy)
    }
}

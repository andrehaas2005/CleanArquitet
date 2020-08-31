//
//  ValidationCompositeTests.swift
//  ValidationTests
//
//  Created by André Haas on 02/09/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import XCTest
import Presentation
import Validation


class ValidationCompositeTests: XCTestCase {

    func test_validate_should_return_error_if_validation_fails() {
        let validationSpy = ValidationCompositeSpy()
        let sut = ValidationComposite(validatins: [validationSpy])
        validationSpy.simulateError("Error 1")
        let messageError = sut.validate(data: ["name" : "André"])
        XCTAssertEqual(messageError, "Error 1")
    }

    func test_validate_should_return_correct_message() {
        let validationSpy = ValidationCompositeSpy()
        let validationSpy2 = ValidationCompositeSpy()
        let sut = ValidationComposite(validatins: [validationSpy, validationSpy2])
        validationSpy2.simulateError("Error 3")
        let messageError = sut.validate(data: ["name" : "André"])
        XCTAssertEqual(messageError, "Error 3")
    }

    func test_validate_should_the_first_error_message() {
        let validationSpy = ValidationCompositeSpy()
        let validationSpy2 = ValidationCompositeSpy()
        let validationSpy3 = ValidationCompositeSpy()
        let sut = ValidationComposite(validatins: [validationSpy, validationSpy2, validationSpy3])
        validationSpy2.simulateError("Error 2")
        validationSpy3.simulateError("Error 3")
        let messageError = sut.validate(data: ["name" : "André"])
        XCTAssertEqual(messageError, "Error 2")
    }

    func test_validate_should_return_if_validation_succeeds() {
        let sut = ValidationComposite(validatins: [ValidationCompositeSpy(), ValidationCompositeSpy()])
        let messageError = sut.validate(data: ["name" : "André"])
        XCTAssertNil(messageError)
    }

    func test_validate_should_call_validation_with_correct_data() {
        let validationSpy = ValidationCompositeSpy()
        let sut = ValidationComposite(validatins: [validationSpy])
        let data = ["name" : "André"]
        _ = sut.validate(data: data)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: data))
    }

}

extension ValidationCompositeTests {
    func makeSut(validatins: [Validation], file: StaticString = #file, line: UInt = #line)-> Validation {
        let sut =  ValidationComposite(validatins: validatins)
          checkMemoryLeak(for: sut, file: file, line: line)
          return sut
      }
}

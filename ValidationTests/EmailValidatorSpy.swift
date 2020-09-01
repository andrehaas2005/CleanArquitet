//
//  EmailValidatorSpy.swift
//  PresentationTests
//
//  Created by André Haas on 31/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//
import Foundation
import Validation


public class EmailValidatorSpy: EmailValidator {
    var isValid = true
    var email: String?

    public func isValid(email: String) -> Bool {
        self.email = email
        return isValid
    }

    func simulateInvalidEmail() {
        isValid = false
    }
}


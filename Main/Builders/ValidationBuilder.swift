//
//  ValidationBuilder.swift
//  Main
//
//  Created by André Haas on 07/09/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import Presentation
import Validation

public final class ValidationBuilder {
    private static var instance: ValidationBuilder?
    private var fieldName: String!
    private var fieldLabel: String!
    private var validations = [Validation]()
    private init(){  }

    static func field(_ name: String) -> ValidationBuilder {
        instance = ValidationBuilder()
        instance!.fieldName = name
        instance!.fieldLabel = name
        return instance!
    }

    public func label(_ name: String) -> ValidationBuilder {
        fieldLabel = name
        return self
    }

    public func required() -> ValidationBuilder {
        validations.append(RequiredFieldValidation(fieldName: fieldName, fieldLabel: fieldLabel))
        return self
    }


    public func email() -> ValidationBuilder {
        validations.append(EmailValidation(fieldName: fieldName, fieldLabel: fieldLabel, emailValidator: makeEmailValidatorAdapter()))
        return self
    }

    public func build() -> [Validation] {
        return validations
    }

    public func sameAs(_ fieldNameToCompare: String) -> ValidationBuilder {
        validations.append(CompareFieldsValidation(fieldName: fieldName, fieldNameToCompare: fieldNameToCompare, fieldLabel: fieldLabel))
        return self
    }
}

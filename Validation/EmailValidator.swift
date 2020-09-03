//
//  EmailValidatorSpy.swift
//  Presentation
//
//  Created by André Haas on 31/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation

public protocol EmailValidator {
    func isValid(email: String) -> Bool
}

//
//  ValidationComposite.swift
//  Validation
//
//  Created by André Haas on 02/09/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import Presentation

public final class ValidationComposite: Validation {
    private let validatins: [Validation]
    public init(validatins: [Validation]) {
        self.validatins = validatins
    }
    public func validate(data: [String : Any]?) -> String? {
        for validation in validatins {
            if let erroMessage =  validation.validate(data: data) {
                return erroMessage
            }
        }
        return nil
    }

}

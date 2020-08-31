//
//  ValidationSpy.swift
//  ValidationTests
//
//  Created by André Haas on 02/09/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import Presentation

public final class ValidationCompositeSpy: Validation {
    var messagError: String?
    var data: [String: Any]?
   public func validate(data: [String : Any]?) -> String? {
        self.data = data
        return messagError
    }

   public func simulateError(_ errorMessage: String){
        self.messagError = errorMessage
    }
}

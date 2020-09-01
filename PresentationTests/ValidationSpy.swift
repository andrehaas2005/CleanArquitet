//
//  ValidationSpy.swift
//  PresentationTests
//
//  Created by André Haas on 01/09/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import Presentation

class ValidationSpy: Validation {
    var data: [String: Any]?
    var errorMessage: String?
    func validate(data: [String : Any]?) -> String? {
        self.data = data
        return errorMessage
    }
    func simulateError(){
        self.errorMessage = "Error"
    }

}

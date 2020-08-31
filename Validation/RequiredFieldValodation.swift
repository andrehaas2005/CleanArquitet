//
//  RequiredFieldValodation.swift
//  Validation
//
//  Created by André Haas on 02/09/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import Presentation

class RequiredFieldValidation: Validation {

    private let fieldName: String
    private let fieldLabel: String
    init(fieldName: String, fieldLabel: String){
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
    }

    func validate(data: [String : Any]?) -> String? {
        guard let fieldName = data?[fieldName] as? String, !fieldName.isEmpty else {return "O campo \(fieldLabel) é obrigatório"}
        return nil
    }
}

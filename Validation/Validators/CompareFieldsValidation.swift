//
//  CompareFieldsValidation.swift
//  Validation
//
//  Created by André Haas on 02/09/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import Presentation

public final class CompareFieldsValidation: Validation, Equatable {

    private let fieldName: String
    private let fieldNameToCompare: String
    private let fieldLabel: String

    public init(fieldName: String, fieldNameToCompare: String, fieldLabel: String){
        self.fieldName = fieldName
        self.fieldNameToCompare = fieldNameToCompare
        self.fieldLabel = fieldLabel
    }

    public func validate(data: [String : Any]?) -> String? {
        guard let fieldValue = data?[fieldName] as? String,
            let fieldValueToCompare = data?[fieldNameToCompare] as? String, fieldValue.elementsEqual(fieldValueToCompare) else {return "O campo \(fieldLabel) é inválido"}
        return nil
    }

    public static func == (lhs: CompareFieldsValidation, rhs: CompareFieldsValidation) -> Bool {
        return lhs.fieldName == rhs.fieldName &&
            lhs.fieldNameToCompare == rhs.fieldNameToCompare &&
            lhs.fieldLabel == rhs.fieldLabel
    }

}

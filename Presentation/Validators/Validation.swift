//
//  Validation.swift
//  Presentation
//
//  Created by André Haas on 01/09/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation

public protocol Validation {
    func validate(data: [String: Any]?) -> String?
}

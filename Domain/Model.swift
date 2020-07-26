//
//  Model.swift
//  Domain
//
//  Created by André Haas on 26/07/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation

public protocol Model: Encodable {}

public extension Model {
    func toData()-> Data? {
        return  try? JSONEncoder().encode(self)
    }
}

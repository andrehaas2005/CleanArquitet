//
//  ExtensionHelper.swift
//  Data
//
//  Created by André Haas on 26/07/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation

public extension Data {
    func toModel<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }

    func toJson() -> [String : Any]? {
        return  try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String : Any]
    }
}

//
//  AccountModel.swift
//  Domain
//
//  Created by André Haas on 25/07/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation

public struct AccountModel: Model {
    public var accessToken: String
    public init(accessToken: String){
        self.accessToken = accessToken
    }
}

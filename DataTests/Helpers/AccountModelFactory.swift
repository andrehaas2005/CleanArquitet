//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by André Haas on 26/07/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import Domain

func makeAccountModel() -> AccountModel {
    return AccountModel(accessToken:  "any_token")
}

func makeAddAccountModel() -> AddAccountModel {
    return AddAccountModel(name: "anyName",
                           email: "any@any.com",
                           password: "any123",
                           passwordConfirmation: "any123")
}


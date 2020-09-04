//
//  SignUpViewModel.swift
//  Presentation
//
//  Created by André Haas on 06/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import Domain

public struct SignUpViewModel: Model {
    public var name: String?
    public var email: String?
    public var password: String?
    public var passwordConfirmation: String?

    public init(name: String? = nil, email: String? = nil, password: String? = nil, passwordConfirmation: String? = nil){
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }

    public func toAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: self.name!, email: self.email!, password: self.password!, passwordConfirmation: self.passwordConfirmation!)
    }
}

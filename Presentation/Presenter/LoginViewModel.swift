//
//  SignUpViewModel.swift
//  Presentation
//
//  Created by André Haas on 06/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import Domain

public struct LoginViewModel: Model {
    public var email: String?
    public var password: String?


    public init(email: String? = nil, password: String? = nil){
        self.email = email
        self.password = password
    }

    public func toAutheticationModel() -> AuthenticationModel {
        return AuthenticationModel(email: self.email!, password: self.password!)
    }
}

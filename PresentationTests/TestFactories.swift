//
//  TestFactories.swift
//  PresentationTests
//
//  Created by André Haas on 06/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import Presentation

func makeSignUpViewModel(name: String? = "anyName", email: String? = "any@any.com", password: String? = "any123", passwordConfirmation: String? = "any123") -> SignUpRequest {
    return SignUpRequest(name: name,
                           email: email,
                           password: password,
                           passwordConfirmation: passwordConfirmation)
}

func makeLoginViewModel(email: String? = "any@any.com", password: String? = "any123")-> LoginRequest {
    return LoginRequest(email: email, password: password)
}

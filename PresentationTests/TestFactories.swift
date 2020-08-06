//
//  TestFactories.swift
//  PresentationTests
//
//  Created by André Haas on 06/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import Presentation

func makeSignUpViewModel(name: String? = "anyName", email: String? = "any@any.com", password: String? = "any123", passwordConfirmation: String? = "any123") -> SignUpViewModel {
    return SignUpViewModel(name: name,
                           email: email,
                           password: password,
                           passwordConfirmation: passwordConfirmation)
}

func makeRequeredAlertViewModel(field: String) -> AlertViewModel {
    return AlertViewModel(title: "Falha na validação", message: "Campo \(field) é obrigatório.")
}

func makeInvalidAlertViewModel(field: String) -> AlertViewModel {
    return AlertViewModel(title: "Falha na validação", message: "Campo \(field) é inválido.")
}

func makeErrorAlertViewModel(message: String) -> AlertViewModel {
    return AlertViewModel(title: "Erro", message: message)
}

func makeSuccessAlertViewModel(message: String) -> AlertViewModel {
    return AlertViewModel(title: "Sucesso", message: message)
}

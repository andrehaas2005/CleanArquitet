//
//  SignUpComposers.swift
//  Main
//
//  Created by André Haas on 30/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import UI
import Presentation
import Validation
import Domain
import Infra

public func makeSignUpController() -> SignUpViewController {

    return makeSignUpControllerWith(addAccount: makeRemoteAddAccount())
}
public func makeSignUpControllerWith(addAccount: AddAccount) -> SignUpViewController {
    let controller = SignUpViewController.instantiate()
    let validationComposite = ValidationComposite(validatins: makeSignUpValidations())

    let presenter = SignUpPresenter(alertView: WeakVarProxy(controller),
                                    addAccount: addAccount,
                                    loadingView: WeakVarProxy(controller),
                                    validation: validationComposite)
    controller.signUp = presenter.signUp
    return controller
}

public func  makeSignUpValidations() -> [Validation]{

    return ValidationBuilder.field("name").label("Nome").required().build() +
        ValidationBuilder.field("email").label("Email").required().email().build() +
        ValidationBuilder.field("password").label("Senha").required().build() +
        ValidationBuilder.field("passwordConfirmation").label("Confirmar Senha").sameAs("password").build()
}

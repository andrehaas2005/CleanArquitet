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

public func makeLoginController() -> LoginViewController {
    return makeLoginControllerWith(authentication: makeRemoteAuthentication())
}
public func makeLoginControllerWith(authentication: Authentication) -> LoginViewController {
    let controller = LoginViewController.instantiate()
    let validationComposite = ValidationComposite(validatins: makeLoginValidations())
    let presenter =  LoginPresenter(alertView: WeakVarProxy(controller), authentication: authentication, loadingView: WeakVarProxy(controller), validation: validationComposite)
    controller.login = presenter.login
    return controller
}

public func  makeLoginValidations() -> [Validation]{

    return ValidationBuilder.field("email").label("Email").required().email().build() +
        ValidationBuilder.field("password").label("Senha").required().build()
}

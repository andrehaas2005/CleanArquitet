//
//  SignUpFactory.swift
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

class ControllerFactory {
    static func makeSignUp(addAccount: AddAccount) -> SignUpViewController {
        let controller = SignUpViewController.instantiate()
        let emailValidatorAdapter = EmailValidatorAdapter()

        let presenter = SignUpPresenter(alertView: controller,
                                        emailValidator: emailValidatorAdapter,
                                        addAccount: addAccount,
                                        loadingView: controller)
        controller.signUp = presenter.signUp
        return controller
    }
}

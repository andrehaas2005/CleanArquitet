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

public final class SignUpComposers {
    public static func composerControllerWith(addAccount: AddAccount) -> SignUpViewController {
        let controller = SignUpViewController.instantiate()
               let emailValidatorAdapter = EmailValidatorAdapter()

               let presenter = SignUpPresenter(alertView: WeakVarProxy(controller),
                                               emailValidator: emailValidatorAdapter,
                                               addAccount: addAccount,
                                               loadingView: WeakVarProxy(controller))
               controller.signUp = presenter.signUp
        return controller
    }
}

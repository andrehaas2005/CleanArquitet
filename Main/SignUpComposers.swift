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
        //               let emailValidatorAdapter = EmailValidatorAdapter()
        let validationComposite = ValidationComposite(validatins: makeValidations())

        let presenter = SignUpPresenter(alertView: WeakVarProxy(controller),
                                        addAccount: addAccount,
                                        loadingView: WeakVarProxy(controller),
                                        validation: validationComposite)
        controller.signUp = presenter.signUp
        return controller
    }

    public static func  makeValidations() -> [Validation]{
        return [
            RequiredFieldValidation(fieldName: "name", fieldLabel: "Nome"),
            RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
            EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorAdapter()),
            RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"),
            RequiredFieldValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar Senha"),
            CompareFieldsValidation(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar Senha")
        ]
    }
}

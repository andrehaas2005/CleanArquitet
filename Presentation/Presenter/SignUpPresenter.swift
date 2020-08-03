//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by André Haas on 03/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import Domain

public class SignUpPresenter {
    private let alertView: AlertView
    private let emailValidator: EmailValidator
    private let addAccount: AddAccount
    public init(alertView: AlertView, emailValidator: EmailValidator, addAccount: AddAccount){
        self.alertView = alertView
        self.emailValidator = emailValidator
        self.addAccount = addAccount
    }
    public func signUp(viewModel: SignUpViewModel){
        if let message = validation(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação",
                                                            message: message))
        } else {
            let addAccountModel = AddAccountModel(name: viewModel.name!, email: viewModel.email!, password: viewModel.password!, passwordConfirmation: viewModel.passwordConfirmation!)
            addAccount.add(addAccountModel: addAccountModel) { (result) in
                
            }

        }
    }

    private func validation(viewModel: SignUpViewModel)-> String? {
        if viewModel.name == nil || viewModel.name!.isEmpty {
            return "Campo nome é obrigatório."
        }else if viewModel.email == nil || viewModel.email!.isEmpty {
            return "Campo email é obrigatório."
        }else if viewModel.password == nil || viewModel.password!.isEmpty {
            return "Campo senha é obrigatório."
        }else if viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation!.isEmpty {
            return "Campo confirmar senha é obrigatório."
        } else if viewModel.password != viewModel.passwordConfirmation {
            return "Campo confirmar senha é inválido."
        } else if !emailValidator.isValid(email: viewModel.email!) {
            return "Campo email é inválido."
        }
        return nil
    }
}

public struct SignUpViewModel {
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
}

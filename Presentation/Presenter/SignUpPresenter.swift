//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by André Haas on 03/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation

public class SignUpPresenter {
    private let alertView: AlertView
    public init(alertView: AlertView){
        self.alertView = alertView
    }
    public func signUp(viewModel: SignUpViewModel){
        if let message = validation(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação",
                                                            message: message))
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

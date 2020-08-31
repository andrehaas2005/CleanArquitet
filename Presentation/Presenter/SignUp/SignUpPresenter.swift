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
    private let loadingView: LoadingView
    public init(alertView: AlertView, emailValidator: EmailValidator, addAccount: AddAccount, loadingView: LoadingView){
        self.alertView = alertView
        self.emailValidator = emailValidator
        self.addAccount = addAccount
        self.loadingView = loadingView
    }
    public func signUp(viewModel: SignUpViewModel){
        if let message = validation(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação",
                                                            message: message))
        } else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            addAccount.add(addAccountModel: SignUpMapper.toAddAccountModel(viewModel: viewModel)) { [weak self] result in
                guard let self = self else { return }
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                switch result {
                case .success(_):
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso",
                                                                         message: "Conta criada com sucesso."))
                case .failure:
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro",
                                                                         message: "Algo inesperado aconteceu, tente novamente mais tarde"))
                }

            }

        }
    }

    private func validation(viewModel: SignUpViewModel)-> String? {
        if viewModel.name == nil || viewModel.name!.isEmpty {
            return "Campo nome é obrigatório."
        } else if viewModel.email == nil || viewModel.email!.isEmpty {
            return "Campo email é obrigatório."
        } else if viewModel.password == nil || viewModel.password!.isEmpty {
            return "Campo senha é obrigatório."
        } else if viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation!.isEmpty {
            return "Campo confirmar senha é obrigatório."
        } else if viewModel.password != viewModel.passwordConfirmation {
            return "Campo confirmar senha é inválido."
        } else if !emailValidator.isValid(email: viewModel.email!) {
            return "Campo email é inválido."
        }
        return nil
    }
}

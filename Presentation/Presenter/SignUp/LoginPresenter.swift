//
//  SignUpPresenter.swift
//  Presentation
//
//  Created by André Haas on 03/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import Domain

public class LoginPresenter {
    private let alertView: AlertView
    private let authentication: Authentication
    private let loadingView: LoadingView
    private let validation: Validation
    public init(alertView: AlertView,
                authentication: Authentication,
                loadingView: LoadingView,
                validation: Validation){
        self.alertView = alertView
        self.authentication = authentication
        self.loadingView = loadingView
        self.validation = validation
    }
    public func login(viewModel: LoginViewModel){
        if let message = validation.validate(data: viewModel.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação",
                                                            message: message))
        } else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))

            authentication.auth(authenticationModel: viewModel.toAutheticationModel()) { [weak self]  (result) in
                guard let self = self else { return }
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                switch result {
                case .success(_):
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Sucesso",
                                                                         message: "Conta criada com sucesso."))
                case .failure(let error):
                    var message: String!
                    switch error {
                    case .expiredSession:
                        message = "Login/Senha não conferem"
                    default:
                        message = "Algo inesperado aconteceu, tente novamente mais tarde"
                    }
                    self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro",
                                                                         message: message))
                }
            }
        }
    }
}

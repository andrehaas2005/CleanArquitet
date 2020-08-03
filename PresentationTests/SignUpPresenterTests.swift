//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by André Haas on 03/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import XCTest

class SignUpPresenter {
    private let alertView: AlertView
    init(alertView: AlertView){
        self.alertView = alertView
    }
    func signUp(viewModel: SignUpViewModel){
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

protocol AlertView {
    func showMessage(viewModel: AlertViewModel)
}

struct AlertViewModel: Equatable {
    var title: String
    var message: String
}

struct SignUpViewModel {
    var name: String?
    var email: String?
    var password: String?
    var passwordConfirmation: String?
}


class SignUpPresenterTests: XCTestCase {

    func test_signUp_should_show_erro_message_if_name_is_not_provided() throws {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(email: "anny_email@mail.com",
                                              password: "any_password",
                                              passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "Campo nome é obrigatório."))
    }

    func test_signUp_should_show_erro_message_if_email_is_not_provided() throws {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "anny_name",
                                              password: "any_password",
                                              passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "Campo email é obrigatório."))
    }

    func test_signUp_should_show_erro_message_if_password_is_not_provided() throws {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "anny_name",
                                              email: "anny_email@mail.com",
                                              passwordConfirmation: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "Campo senha é obrigatório."))
    }

    func test_signUp_should_show_erro_message_if_password_conformation_is_not_provided() throws {
        let (sut, alertViewSpy) = makeSut()
        let signUpViewModel = SignUpViewModel(name: "anny_name",
                                              email: "anny_email@mail.com",
                                              password: "any_password")
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, AlertViewModel(title: "Falha na validação", message: "Campo confirmar senha é obrigatório."))
    }

}

extension SignUpPresenterTests {
    func makeSut() -> (sut: SignUpPresenter, alertView: AlertViewSpy) {
        let alertViewSpy = AlertViewSpy()
        let sut = SignUpPresenter(alertView: alertViewSpy)
        return (sut, alertViewSpy)
    }
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel

        }
    }

}

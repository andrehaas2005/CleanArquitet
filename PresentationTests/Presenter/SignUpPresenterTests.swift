//
//  PresentationTests.swift
//  PresentationTests
//
//  Created by André Haas on 03/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import XCTest
import Presentation
import Domain

class SignUpPresenterTests: XCTestCase {

    func test_signUp_should_show_erro_message_if_name_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(name: nil))
        XCTAssertEqual(alertViewSpy.viewModel, makeRequeredAlertViewModel(field: "nome"))
    }

    func test_signUp_should_show_erro_message_if_email_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(email: nil))
        XCTAssertEqual(alertViewSpy.viewModel,  makeRequeredAlertViewModel(field: "email"))
    }

    func test_signUp_should_show_erro_message_if_password_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(password: nil))
        XCTAssertEqual(alertViewSpy.viewModel,  makeRequeredAlertViewModel(field: "senha"))
    }

    func test_signUp_should_show_erro_message_if_password_conformation_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: nil))
        XCTAssertEqual(alertViewSpy.viewModel,  makeRequeredAlertViewModel(field: "confirmar senha"))
    }

    func test_signUp_should_show_erro_message_if_password_conformation_is_not_math() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: "wrong_password"))
        XCTAssertEqual(alertViewSpy.viewModel, makeInvalidAlertViewModel(field: "confirmar senha"))
    }

    func test_signUp_should_show_erro_message_if_invalid_email_is_provider() throws {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(alertView: alertViewSpy, emailValidatorSpy: emailValidatorSpy)
        let signUpViewModel = makeSignUpViewModel()
        emailValidatorSpy.simulateInvalidEmail()
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(alertViewSpy.viewModel, makeInvalidAlertViewModel(field: "email"))
    }

    func test_signUp_should_call_emailValidator_with_correct_email() throws {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy)
        let signUpViewModel = makeSignUpViewModel()
        sut.signUp(viewModel: signUpViewModel)
        XCTAssertEqual(emailValidatorSpy.email, signUpViewModel.email)
    }

    func test_signUp_should_call_addAccount_with_correct_value() throws {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy)
        sut.signUp(viewModel: makeSignUpViewModel())
        XCTAssertEqual(addAccountSpy.addAccountModel, makeAddAccountModel())
    }

}

extension SignUpPresenterTests {
    func makeSut(alertView: AlertViewSpy  = AlertViewSpy(), emailValidatorSpy: EmailValidatorSpy = EmailValidatorSpy(), addAccount: AddAccount = AddAccountSpy()) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidatorSpy, addAccount: addAccount)
        return sut
    }

    func makeRequeredAlertViewModel(field: String) -> AlertViewModel {
        return AlertViewModel(title: "Falha na validação", message: "Campo \(field) é obrigatório.")
    }

    func makeInvalidAlertViewModel(field: String) -> AlertViewModel {
        return AlertViewModel(title: "Falha na validação", message: "Campo \(field) é inválido.")
    }

    func makeSignUpViewModel(name: String? = "anyName", email: String? = "any@any.com", password: String? = "any123", passwordConfirmation: String? = "any123") -> SignUpViewModel {
        return SignUpViewModel(name: name,
                               email: email,
                               password: password,
                               passwordConfirmation: passwordConfirmation)
    }

    class EmailValidatorSpy: EmailValidator {
        var isValid = true
        var email: String?
        func isValid(email: String) -> Bool {
            self.email = email
            return isValid
        }

        func simulateInvalidEmail() {
            self.isValid = false
        }
    }
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel

        }
    }

    class AddAccountSpy: AddAccount {
        var addAccountModel: AddAccountModel?
        func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
            self.addAccountModel = addAccountModel
        }


    }

}

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
import Data

class SignUpPresenterTests: XCTestCase {

    func test_signUp_should_show_erro_message_if_name_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] (viewModel) in
            guard let self = self else { return }
            XCTAssertEqual(viewModel, self.makeRequeredAlertViewModel(field: "nome"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel(name: nil))
        wait(for: [exp], timeout: 1.0)
    }

    func test_signUp_should_show_erro_message_if_email_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] (viewModel) in
            guard let self = self else { return }
            XCTAssertEqual(viewModel, self.makeRequeredAlertViewModel(field: "email"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel(email: nil))
        wait(for: [exp], timeout: 1.0)
    }

    func test_signUp_should_show_erro_message_if_password_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] (viewModel) in
            guard let self = self else { return }
            XCTAssertEqual(viewModel, self.makeRequeredAlertViewModel(field: "senha"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel(password: nil))
        wait(for: [exp], timeout: 1.0)
    }

    func test_signUp_should_show_erro_message_if_password_conformation_is_not_provided() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] (viewModel) in
            guard let self = self else { return }
            XCTAssertEqual(viewModel, self.makeRequeredAlertViewModel(field: "confirmar senha"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: nil))
        wait(for: [exp], timeout: 1.0)
    }

    func test_signUp_should_show_erro_message_if_password_conformation_is_not_math() throws {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertView: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] (viewModel) in
            guard let self = self else { return }
            XCTAssertEqual(viewModel, self.makeInvalidAlertViewModel(field: "confirmar senha"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpViewModel(passwordConfirmation: "wrong_password"))
        wait(for: [exp], timeout: 1.0)
    }

    func test_signUp_should_show_erro_message_if_invalid_email_is_provider() throws {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(alertView: alertViewSpy, emailValidatorSpy: emailValidatorSpy)
        let exp = expectation(description: "waiting")
        let signUpViewModel = makeSignUpViewModel()
        alertViewSpy.observe { [weak self] (viewModel) in
            guard let self = self else { return }
            XCTAssertEqual(viewModel, self.makeInvalidAlertViewModel(field: "email"))
            exp.fulfill()
        }

        emailValidatorSpy.simulateInvalidEmail()
        sut.signUp(viewModel: signUpViewModel)
        wait(for: [exp], timeout: 1.0)
    }

    func test_signUp_should_show_erro_message_if_addAccount_fails() throws {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        let signUpViewModel = makeSignUpViewModel()
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] (viewModel) in
            guard let self = self else { return }
            XCTAssertEqual(viewModel, self.makeErrorAlertViewModel(message: "Algo inesperado aconteceu, tente novamente mais tarde"))
            exp.fulfill()
        }
        sut.signUp(viewModel: signUpViewModel)
        addAccountSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1.0)
    }

    func test_signUp_should_show_loading_befoure_call_addAccount() throws {
        let loadingViewSpy = LoadingViewSpy()
        let sut = makeSut(loadingView: loadingViewSpy)
        let exp = expectation(description: "waiting")
        loadingViewSpy.observe { (viewModel) in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
            exp.fulfill()
        }

        sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_hiden_loading_befoure_call_addAccount() throws {
        let loadingViewSpy = LoadingViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy, loadingView: loadingViewSpy)
        let exp = expectation(description: "waiting")
        loadingViewSpy.observe { (viewModel) in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
            exp.fulfill()
        }

        sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [exp], timeout: 1)
        let exp2 = expectation(description: "waiting")
        loadingViewSpy.observe { (viewModel) in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
            exp2.fulfill()
        }
        addAccountSpy.completeWithError(.unexpected)
        wait(for: [exp2], timeout: 1)
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
    func makeSut(alertView: AlertViewSpy  = AlertViewSpy(), emailValidatorSpy: EmailValidatorSpy = EmailValidatorSpy(), addAccount: AddAccount = AddAccountSpy(), loadingView: LoadingView = LoadingViewSpy(),file: StaticString = #file, line: UInt = #line) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertView, emailValidator: emailValidatorSpy, addAccount: addAccount, loadingView: loadingView)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }

    func makeRequeredAlertViewModel(field: String) -> AlertViewModel {
        return AlertViewModel(title: "Falha na validação", message: "Campo \(field) é obrigatório.")
    }

    func makeInvalidAlertViewModel(field: String) -> AlertViewModel {
        return AlertViewModel(title: "Falha na validação", message: "Campo \(field) é inválido.")
    }

    func makeErrorAlertViewModel(message: String) -> AlertViewModel {
        return AlertViewModel(title: "Erro", message: message)
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
        var emit: ((AlertViewModel)->Void)?

        func observe(completion: @escaping (AlertViewModel)->Void){
            self.emit = completion
        }
        func showMessage(viewModel: AlertViewModel) {
            emit?(viewModel)
        }
    }

    class AddAccountSpy: AddAccount {
        var addAccountModel: AddAccountModel?
        var completion: ((Result<AccountModel, DomainError>)-> Void)?
        func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
            self.addAccountModel = addAccountModel
            self.completion = completion
        }

        func completeWithError(_ error: DomainError){
            completion?(.failure(error))
        }
    }
}
class LoadingViewSpy: LoadingView {
    var viewModel: LoadingViewModel?
    var emit: ((LoadingViewModel)->Void)?

    func observe(completion: @escaping (LoadingViewModel)->Void){
        self.emit = completion
    }
    func display(viewModel: LoadingViewModel) {
        self.emit?(viewModel)
    }
}

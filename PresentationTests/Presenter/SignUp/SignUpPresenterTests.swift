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

    func test_signUp_should_show_generic_erro_message_if_addAccount_fails() throws {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        let signUpViewModel = makeSignUpViewModel()
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] (viewModel) in
            guard  self != nil else { return }
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente mais tarde"))
            exp.fulfill()
        }
        sut.signUp(viewModel: signUpViewModel)
        addAccountSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1.0)
    }

    func test_signUp_should_show_email_in_use_erro_message_if_addAccount_fails() throws {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        let signUpViewModel = makeSignUpViewModel()
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] (viewModel) in
            guard  self != nil else { return }
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Esse e-mail já esta em uso"))
            exp.fulfill()
        }
        sut.signUp(viewModel: signUpViewModel)
        addAccountSpy.completeWithError(.emailInUse)
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

    func test_signUp_should_show_erro_message_if_addAccount_success() throws {
        let alertViewSpy = AlertViewSpy()
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(alertView: alertViewSpy, addAccount: addAccountSpy)
        let signUpViewModel = makeSignUpViewModel()
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] (viewModel) in
            guard  self != nil else { return }
            XCTAssertEqual(viewModel, AlertViewModel(title: "Sucesso", message: "Conta criada com sucesso."))
            exp.fulfill()
        }
        sut.signUp(viewModel: signUpViewModel)
        addAccountSpy.completeWithAccount(makeAccountModel())
        wait(for: [exp], timeout: 1.0)
    }

    func test_signUp_should_call_addAccount_with_correct_value() throws {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccount: addAccountSpy)
        sut.signUp(viewModel: makeSignUpViewModel())
        XCTAssertEqual(addAccountSpy.addAccountModel, makeAddAccountModel())
    }

    func test_signUp_should_call_validation_with_correct_values(){
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        let viewModel = makeSignUpViewModel()
        sut.signUp(viewModel:viewModel)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: viewModel.toJson()!))
    }

    func test_signUp_should_show_erro_message_if_validation_fails() throws {
        let alertViewSpy = AlertViewSpy()
         let validationSpy = ValidationSpy()
        let sut = makeSut(alertView: alertViewSpy, validation: validationSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] (viewModel) in
            guard  self != nil else { return }

            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Error"))
            exp.fulfill()
        }
        validationSpy.simulateError()
        sut.signUp(viewModel: makeSignUpViewModel())
        wait(for: [exp], timeout: 1.0)
    }

}

extension SignUpPresenterTests {
    func makeSut(alertView: AlertViewSpy  = AlertViewSpy(), addAccount: AddAccount = AddAccountSpy(), loadingView: LoadingView = LoadingViewSpy(),validation: ValidationSpy = ValidationSpy(), file: StaticString = #file, line: UInt = #line) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertView, addAccount: addAccount, loadingView: loadingView, validation: validation)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }

}

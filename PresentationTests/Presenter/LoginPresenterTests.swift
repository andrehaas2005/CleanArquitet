//
//  LoginPresenterTests.swift
//  PresentationTests
//
//  Created by André Haas on 04/09/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import XCTest
import Presentation
import Domain
import Data

class LoginPresenterTests: XCTestCase {

    func test_login_should_call_validation_with_correct_values(){
        let validationSpy = ValidationSpy()
        let sut = makeSut(validation: validationSpy)
        let viewModel = makeLoginViewModel()
        sut.login(viewModel: viewModel)
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
        sut.login(viewModel: makeLoginViewModel())
        wait(for: [exp], timeout: 1.0)
    }


    //
    func test_signUp_should_show_generic_erro_message_if_addAccount_fails() throws {
        let alertViewSpy = AlertViewSpy()
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(alertView: alertViewSpy, authentication: authenticationSpy)
        let loginViewModel = makeLoginViewModel()
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] (viewModel) in
            guard  self != nil else { return }
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente mais tarde"))
            exp.fulfill()
        }
        sut.login(viewModel: loginViewModel)
        authenticationSpy.completeWithError(.unexpected)
        wait(for: [exp], timeout: 1.0)
    }

    func test_signUp_should_show_email_in_use_erro_message_if_addAccount_fails() throws {
        let alertViewSpy = AlertViewSpy()
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(alertView: alertViewSpy, authentication: authenticationSpy)
        let loginViewModel = makeLoginViewModel()
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] (viewModel) in
            guard  self != nil else { return }
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Login/Senha não conferem"))
            exp.fulfill()
        }
        sut.login(viewModel: loginViewModel)
        authenticationSpy.completeWithError(.expiredSession)
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

        sut.login(viewModel: makeLoginViewModel())
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_hiden_loading_befoure_call_addAccount() throws {
        let loadingViewSpy = LoadingViewSpy()
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut( authentication: authenticationSpy, loadingView: loadingViewSpy)
        let exp = expectation(description: "waiting")
        loadingViewSpy.observe { (viewModel) in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
            exp.fulfill()
        }

        sut.login(viewModel: makeLoginViewModel())
        wait(for: [exp], timeout: 1)
        let exp2 = expectation(description: "waiting")
        loadingViewSpy.observe { (viewModel) in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
            exp2.fulfill()
        }
        authenticationSpy.completeWithError(.unexpected)
        wait(for: [exp2], timeout: 1)
    }

    func test_signUp_should_show_erro_message_if_addAccount_success() throws {
        let alertViewSpy = AlertViewSpy()
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(alertView: alertViewSpy, authentication: authenticationSpy)
        let loginViewModel = makeLoginViewModel()
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] (viewModel) in
            guard  self != nil else { return }
            XCTAssertEqual(viewModel, AlertViewModel(title: "Sucesso", message: "Acesso autorizado."))
            exp.fulfill()
        }
        sut.login(viewModel: loginViewModel)
        authenticationSpy.completeWithAccount(makeAccountModel())
        wait(for: [exp], timeout: 1.0)
    }

    func test_signUp_should_call_addAccount_with_correct_value() throws {
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(authentication: authenticationSpy)
        sut.login(viewModel: makeLoginViewModel())
        XCTAssertEqual(authenticationSpy.authenticationModel, makeLoginViewModel().toAutheticationModel())
    }

}

extension LoginPresenterTests {
    func makeSut(alertView: AlertViewSpy  = AlertViewSpy(), authentication: Authentication = AuthenticationSpy(), loadingView: LoadingView = LoadingViewSpy(),validation: ValidationSpy = ValidationSpy(), file: StaticString = #file, line: UInt = #line) -> LoginPresenter {
        let sut = LoginPresenter(alertView: alertView, authentication: authentication, loadingView: loadingView, validation: validation)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }

}

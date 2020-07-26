//
//  DataTests.swift
//  DataTests
//
//  Created by André Haas on 25/07/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import XCTest
import Domain
import Data

class RemoteAddAccountTests: XCTestCase {

    func test_post_httpClient_correct_url(){
        let url = URL(string: "http://any-url.com")!
        let (sut, httpClientSpy) = makeSut()
        sut.add(addAccountModel: makeAddAccountModel()){_ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }

    func test_post_httpClient_correct_data(){
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel){_ in }
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }

    func test_post_httpClient_completion_error(){
        let (sut, httpClientSpy) = makeSut()
        let exp = expectation(description: "wainting")
        sut.add(addAccountModel: makeAddAccountModel()) { result in
            switch result {
            case .success:
                XCTFail("Expected error received \(result) instead")
            case .failure(let error):
                XCTAssertEqual(error, .unexpected)
            }
            exp.fulfill()
        }
        httpClientSpy.completeWithError(.noConnectivity)
        wait(for: [exp], timeout: 1)
    }

    func test_post_httpClient_completion_account(){
        let (sut, httpClientSpy) = makeSut()
        let exp = expectation(description: "wainting")
        let expectedAccount = makeAccountModel()
        sut.add(addAccountModel: makeAddAccountModel()) { result in
            switch result {
            case .success(let account):
                XCTAssertEqual(account, expectedAccount)
            case .failure:
                XCTFail("Expected error received \(result) instead")

            }
            exp.fulfill()
        }
        httpClientSpy.completeWithData(expectedAccount.toData()!)
        wait(for: [exp], timeout: 1)
    }

}

extension RemoteAddAccountTests {

    func makeSut(url: URL = URL(string: "http://any-url.com")!)-> (sut: RemoteAddAccount, httpClient: HttpClientSpy){
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }

    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "anyName",
                               email: "any@any.com",
                               password: "any123",
                               passwordConfirmation: "any123")
    }

    func makeAccountModel() -> AccountModel {
        return AccountModel(id: "any_id", name: "anyName",
                            email: "any@any.com",
                            password: "any123")
    }

    class HttpClientSpy: HttpPostClient {

        var urls = [URL]()
        var data: Data?
        var completion: ((Result<Data, HttpError>) -> Void)?

        func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void) {
            self.urls.append(url)
            self.data = data
            self.completion = completion
        }

        func completeWithError(_ error: HttpError){
            self.completion?(.failure(error))
        }

        func completeWithData(_ data: Data){
            self.completion?(.success(data))
        }

    }
}

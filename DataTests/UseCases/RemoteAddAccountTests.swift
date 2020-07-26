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
        let url = makeUrl()
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
        expect(sut, completeWith: .failure(.unexpected)) {
        httpClientSpy.completeWithError(.noConnectivity)
        }
    }

    func test_post_httpClient_completion_account(){
        let (sut, httpClientSpy) = makeSut()
        let account = makeAccountModel()
        expect(sut, completeWith: .success(account)) {
            httpClientSpy.completeWithData(account.toData()!)
        }
    }

    func test_post_httpClient_completion_account_invalid(){
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.completeWithData(makeInvalidData())
        }
    }

}

extension RemoteAddAccountTests {

    func makeSut(url: URL = URL(string: "http://any-url.com")!)-> (sut: RemoteAddAccount, httpClient: HttpClientSpy){
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }

    func expect(_ sut: RemoteAddAccount, completeWith expectedResult: Result<AccountModel, DomainError>, when action: ()->Void){

        let exp = expectation(description: "wainting")
        sut.add(addAccountModel: makeAddAccountModel()) { receiveResult in
            switch (expectedResult, receiveResult) {
            case (.failure(let expectedError),.failure(let receiveError)):
                 XCTAssertEqual(expectedError, receiveError)
            case (.success(let expectedAccount),.success(let receiveAccount)):
                XCTAssertEqual(expectedAccount, receiveAccount)
            default: XCTFail("Expected \(expectedResult) received \(receiveResult) instead")

            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }

    func makeUrl() -> URL {
        return URL(string: "http://any-url.com")!
    }

    func makeInvalidData() -> Data {
        return Data("invalid_data".utf8)
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

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
        sut.add(addAccountModel: makeAddAccountModel())
        XCTAssertEqual(httpClientSpy.url, url)
    }

    func test_post_httpClient_correct_data(){
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
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

    class HttpClientSpy: HttpPostClient {
        var url: URL?
        var data: Data?
        func post(to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
    }
}

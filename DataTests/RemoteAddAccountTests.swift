//
//  DataTests.swift
//  DataTests
//
//  Created by André Haas on 25/07/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import XCTest
import Domain

class RemoteAddAccount {
    private let url: URL
    private let httpClient: HttpPostClient

    init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }

    func add(addAccountModel: AddAccountModel){
        let data = try? JSONEncoder().encode(addAccountModel)
        httpClient.post(to: url, with: data)
    }

}

protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}

class RemoteAddAccountTests: XCTestCase {

    func test_post_httpClient_correct_url(){
        let url = URL(string: "http://any-url.com")!
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        let addAccountModel = AddAccountModel(name: "anyName", email: "any@any.com", password: "any123", passwordConfirmation: "any123")
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httpClientSpy.url, url)
    }

    func test_post_httpClient_correct_data(){
        let url = URL(string: "http://any-url.com")!
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
         let addAccountModel = AddAccountModel(name: "anyName", email: "any@any.com", password: "any123", passwordConfirmation: "any123")
        sut.add(addAccountModel: addAccountModel)
        let data = try? JSONEncoder().encode(addAccountModel)
        XCTAssertEqual(httpClientSpy.data, data)
    }

}

extension RemoteAddAccountTests {

    class HttpClientSpy: HttpPostClient {
        var url: URL?
        var data: Data?
        func post(to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
    }
}

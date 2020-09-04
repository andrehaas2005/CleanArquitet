//
//  RemoteAuthenticationTests.swift
//  DataTests
//
//  Created by André Haas on 04/09/20.
//  Copyright © 2020 André Haas. All rights reserved.
//
import XCTest
import Domain
import Data


class RemoteAuthenticationTests: XCTestCase {

    func test_post_httpClient_correct_url(){
        let url = makeUrl()
        let (sut, httpClientSpy) = makeSut()

        sut.auth(authenticationModel: makeAuthencitarionModel()){_ in}
        XCTAssertEqual(httpClientSpy.urls, [url])
    }

    func test_post_httpClient_correct_data(){
        let (sut, httpClientSpy) = makeSut()
        let authenticationModel = makeAuthencitarionModel()
        sut.auth(authenticationModel: authenticationModel){_ in}
        XCTAssertEqual(httpClientSpy.data, authenticationModel.toData())
    }


    func test_post_httpClient_completion_error(){
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
        httpClientSpy.completeWithError(.noConnectivity)
        })
    }

    func test_auth_should_complete_with_expired_in_use_error_if_client_completes_with_unauthorized(){
           let (sut, httpClientSpy) = makeSut()
           expect(sut, completeWith: .failure(.expiredSession), when: {
           httpClientSpy.completeWithError(.unauthorized)
           })
       }

}


extension RemoteAuthenticationTests {

    func makeSut(url: URL = URL(string: "http://any-url.com")!, file: StaticString = #file, line: UInt = #line)-> (sut: RemoteAuthentication, httpClient: HttpClientSpy){
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAuthentication(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut,file: file, line: line)
        checkMemoryLeak(for: httpClientSpy,file: file, line: line)
        return (sut, httpClientSpy)
    }

    func expect(_ sut: RemoteAuthentication, completeWith expectedResult: Authentication.Result, when action: ()->Void, file: StaticString = #file, line: UInt = #line){

        let exp = expectation(description: "wainting")
        sut.auth(authenticationModel: makeAuthencitarionModel()) { receiveResult in
            switch (expectedResult, receiveResult) {
            case (.failure(let expectedError),.failure(let receiveError)):
                XCTAssertEqual(expectedError, receiveError, file: file, line: line)
            case (.success(let expectedAccount),.success(let receiveAccount)):
                XCTAssertEqual(expectedAccount, receiveAccount, file: file, line: line)
            default: XCTFail("Expected \(expectedResult) received \(receiveResult) instead", file: file, line: line)

            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
}

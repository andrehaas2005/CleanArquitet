//
//  InfraTests.swift
//  InfraTests
//
//  Created by André Haas on 26/07/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import XCTest
import Alamofire
import Data
import Infra


class AlamofireAdapterTest: XCTestCase {

    func test_post_shold_make_request_with_valied_url_method() throws {
        let url = makeUrl()
        testResquestFor(url: makeUrl(), data: makeValidData()) { (request) in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("POST", request.httpMethod)
            XCTAssertNotNil(request.httpBodyStream)
        }
    }

    func test_post_shold_make_request_with_no_data() throws {
        testResquestFor(data: nil) { (request) in
            XCTAssertNil(request.httpBodyStream)
        }
    }

    func test_post_shold_make_request_with_no_data_completion_error() throws {
        expectResult(.failure(.noConnectivity), when: (data: nil, response: nil, error: makeError()))
         expectResult(.failure(HttpError.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 300), error: nil))
    }

    func test_post_shold_make_request_with_data_completion_data() throws {
        expectResult(.success(makeValidData()), when: (data: makeValidData(), response:makeHttpResponse(), error: nil))
    }

    func test_post_shold_make_request_with_data_completion_fail() throws {
        expectResult(.success(nil), when: (data: nil, response:makeHttpResponse(statusCode: 204), error: nil))
        expectResult(.success(nil), when: (data: makeEmptyData(), response:makeHttpResponse(statusCode: 204), error: nil))
        expectResult(.success(nil), when: (data: makeValidData(), response:makeHttpResponse(statusCode: 204), error: nil))
    }

    func test_post_shold_make_request_with_error_on_all_invalid_cases() throws {
        expectResult(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(), error: makeError()))
        expectResult(.failure(.noConnectivity), when: (data: makeValidData(), response: nil, error: makeError()))
        expectResult(.failure(.noConnectivity), when: (data: makeValidData(), response: nil, error: nil))
        expectResult(.failure(.noConnectivity), when: (data: nil, response: makeHttpResponse(), error: makeError()))
        expectResult(.failure(.noConnectivity), when: (data: nil, response: makeHttpResponse(), error: nil))
        expectResult(.failure(.noConnectivity), when: (data: nil, response: nil, error: nil))
    }

    func test_post_shold_make_request_with_error_when_completion_with_400() throws {
        expectResult(.failure(HttpError.forbidden), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 403), error: nil))
        expectResult(.failure(HttpError.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 400), error: nil))
        expectResult(.failure(HttpError.unauthorized), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 401), error: nil))
        expectResult(.failure(HttpError.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 500), error: nil))

    }
}

extension AlamofireAdapterTest {
    func makeSut(file: StaticString = #file, line: UInt = #line) -> AlamofireAdapter {
        let configiration = URLSessionConfiguration.default
        configiration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configiration)
        let sut = AlamofireAdapter(session: session)
        checkMemoryLeak(for: sut,file: file, line: line)
        return sut
    }

    func testResquestFor(url: URL = makeUrl(), data: Data?, action: @escaping (URLRequest) -> Void){
        let sut = makeSut()
        let exp = expectation(description: "wating")
        sut.post(to: url, with: data) {_ in exp.fulfill()}
        var request: URLRequest?
        UrlProtocolStub.observeRequest { request = $0 }
        wait(for: [exp], timeout: 1)
        action(request!)
    }

    func expectResult(_ expectedResult: Result<Data?, HttpError>, when stub: (data: Data?, response: HTTPURLResponse?, error: Error?), file: StaticString = #file, line: UInt = #line) {
        let sut = makeSut()
        UrlProtocolStub.simulate(data: stub.data, response: stub.response, error: stub.error)
        let exp = expectation(description: "waiting")
        sut.post(to: makeUrl(), with: makeValidData(), completion: {
            receivedResult in
            switch (expectedResult, receivedResult) {
            case (.success(let expectedData), .success(let receivedData)):
                XCTAssertEqual(expectedData, receivedData,file: file, line: line)
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError,file: file, line: line)
            default:
                XCTFail("Expected \(expectedResult) got \(receivedResult)")
            }
            exp.fulfill()
        })
        wait(for: [exp], timeout: 1)
    }
}

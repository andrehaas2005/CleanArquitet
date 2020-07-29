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

class AlamofireAdapter{
    private let session: Session

    init(session: Session = .default) {
        self.session = session
    }

    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void){
        session.request(url, method: .post, parameters: data?.toJson(), encoding: JSONEncoding.default).responseData { (dataResponse) in
            switch dataResponse.result {

            case .success:
                break
            case .failure:
                completion(.failure(.noConnectivity))
            }
        }
    }
}


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

    func expectResult(_ expectedResult: Result<Data, HttpError>, when stub: (data: Data?, response: HTTPURLResponse?, error: Error?), file: StaticString = #file, line: UInt = #line) {
        let sut = makeSut()
        UrlProtocolStub.simulate(data: stub.data, response: stub.response, error: stub.error)
        let exp = expectation(description: "waiting")
        sut.post(to: makeUrl(), with: makeValidData(), completion: {
            receivedResult in
            switch (expectedResult, receivedResult) {
            case (.success(let expectedData), .success(let receivedData)):
                XCTAssertEqual(expectedData, receivedData)
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError)
            default:
                XCTFail("Expected \(expectedResult) got \(receivedResult)")
            }
            exp.fulfill()
        })
        wait(for: [exp], timeout: 1)
    }
}

class UrlProtocolStub: URLProtocol {
    static var emit: ((URLRequest) -> Void)?
    static var url: URL?
    static var data: Data?
    static var response: HTTPURLResponse?
    static var error: Error?

    static func observeRequest(completion: @escaping (URLRequest) -> Void){
        UrlProtocolStub.emit = completion
    }

    static func simulate(data: Data?, response: HTTPURLResponse?, error: Error?){
        UrlProtocolStub.data = data
        UrlProtocolStub.response = response
        UrlProtocolStub.error = error
    }

    open override class func canInit(with request: URLRequest) -> Bool {
        return true

    }
    open override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    open override func startLoading() {
        UrlProtocolStub.emit?(request)
        if let data = UrlProtocolStub.data {
            client?.urlProtocol(self, didLoad: data)
        }

        if let response = UrlProtocolStub.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }

        if let error = UrlProtocolStub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    open override func stopLoading() {}
}

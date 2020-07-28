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

    func post(to url: URL, with data: Data?){
        session.request(url, method: .post, parameters: data?.toJson(), encoding: JSONEncoding.default).resume()
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
        sut.post(to: url, with: data)
        let exp = expectation(description: "wating")
        UrlProtocolStub.observeRequest { (request) in
            action(request)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)

    }
}

class UrlProtocolStub: URLProtocol {
    static var emit: ((URLRequest) -> Void)?

    static var url: URL?

    static func observeRequest(completion: @escaping (URLRequest) -> Void){
        UrlProtocolStub.emit = completion
    }

    open override class func canInit(with request: URLRequest) -> Bool {
        return true

    }
    open override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    open override func startLoading() {
        UrlProtocolStub.emit?(request)
    }
    open override func stopLoading() {}
}

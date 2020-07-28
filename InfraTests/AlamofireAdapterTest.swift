//
//  InfraTests.swift
//  InfraTests
//
//  Created by André Haas on 26/07/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import XCTest
import Alamofire

class AlamofireAdapter{
    private let session: Session

    init(session: Session = .default) {
        self.session = session
    }

    func post(to url: URL, with data: Data?){
        let json = data == nil ? nil : try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? Parameters
        session.request(url, method: .post, parameters: json, encoding: JSONEncoding.default).resume()
    }
}


class AlamofireAdapterTest: XCTestCase {

    func test_post_shold_make_request_with_valied_url_method() throws {
        let url = makeUrl()
        let configiration = URLSessionConfiguration.default
        configiration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configiration)
        let sut = AlamofireAdapter(session: session)
        sut.post(to: url, with: makeValidData())
        let exp = expectation(description: "wating")
        UrlProtocolStub.observeRequest { (request) in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("POST", request.httpMethod)
            XCTAssertNotNil(request.httpBodyStream)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }

    func test_post_shold_make_request_with_no_data() throws {
        let url = makeUrl()
        let configiration = URLSessionConfiguration.default
        configiration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configiration)
        let sut = AlamofireAdapter(session: session)
        sut.post(to: url, with: nil)
        let exp = expectation(description: "wating")
        UrlProtocolStub.observeRequest { (request) in
            XCTAssertNil(request.httpBodyStream)
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

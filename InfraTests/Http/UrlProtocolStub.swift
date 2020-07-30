//
//  UrlProtocolStub.swift
//  InfraTests
//
//  Created by André Haas on 30/07/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation


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

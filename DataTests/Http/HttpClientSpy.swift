//
//  HttpClientSpy.swift
//  DataTests
//
//  Created by André Haas on 26/07/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import Data

class HttpClientSpy: HttpPostClient {

    var urls = [URL]()
    var data: Data?
    var completion: ((Result<Data?, HttpError>) -> Void)?

    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
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

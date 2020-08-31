//
//  UseCaseFactory.swift
//  Main
//
//  Created by André Haas on 30/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import Domain
import Infra
import Data

final public class UseCaseFactory {
    private static let httpClient = AlamofireAdapter()
    private static let apiBaseUrl = Environment.varieble(.apiBaseUrl)

    private static func makeUrl(path: String) -> URL {
        return URL(string: "\(apiBaseUrl)/\(path)")!
    }
    static func makeRemoteAddAccount() -> AddAccount{
        return RemoteAddAccount(url: makeUrl(path: "signup"), httpClient: httpClient)
    }
}

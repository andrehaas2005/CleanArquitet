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
    static func makeRemoteAddAccount() -> AddAccount{
        let url = URL(string: "https://clean-node-api.herokuapp.com/api/signup")!
        let alamofireAdapter = AlamofireAdapter()
        return RemoteAddAccount(url: url, httpClient: alamofireAdapter)
    }
}

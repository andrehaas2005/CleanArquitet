//
//  UseCaseFactory.swift
//  Main
//
//  Created by André Haas on 30/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import Domain
import Data

public func makeRemoteAuthentication() -> Authentication {
    return makeRemoteAuthenticationWith(httpClient: makeAlamofireAdapter())
}

public func makeRemoteAuthenticationWith(httpClient: HttpPostClient) -> Authentication {
    let remoteAuthentication = RemoteAuthentication(url:  makeApiUrl(path: "login"), httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteAuthentication)
}

//
//  ApiUrlFActory.swift
//  Main
//
//  Created by André Haas on 04/09/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation

public func makeApiUrl(path: String) -> URL {
    return URL(string: "\(Environment.varieble(.apiBaseUrl))/\(path)")!
}

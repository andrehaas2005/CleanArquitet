//
//  DomainError.swift
//  Domain
//
//  Created by André Haas on 26/07/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation

public enum DomainError: Error {
    case unexpected
    case emailInUse
    case expiredSession
}

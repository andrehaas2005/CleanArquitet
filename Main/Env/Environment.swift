//
//  Environment.swift
//  Main
//
//  Created by André Haas on 30/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation

public final class Environment {
    public enum EnvironmentVarieble: String {
        case apiBaseUrl = "API_BASE_URL"
    }
    public static func varieble(_ key: EnvironmentVarieble) -> String {
        return Bundle.main.infoDictionary![key.rawValue] as! String
    }
}

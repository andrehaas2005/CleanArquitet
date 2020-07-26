//
//  TestExtension.swift
//  DataTests
//
//  Created by André Haas on 26/07/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #file, line: UInt = #line){
        addTeardownBlock {[weak instance] in
            XCTAssertNil(instance,file: file, line: line)
        }
    }
}

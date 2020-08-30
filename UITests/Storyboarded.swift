//
//  Storyboarded.swift
//  UITests
//
//  Created by André Haas on 28/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import UIKit

public protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController{
    public static func instantiate() -> Self {
        let vcName = String(describing: self)
        let sbName = vcName.components(separatedBy: "ViewController")[0]
        let bundle = Bundle(for: Self.self)
        let sb = UIStoryboard(name: sbName, bundle: bundle)
        return sb.instantiateViewController(identifier: vcName) as! Self
    }
}

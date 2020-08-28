//
//  TestExtensions.swift
//  UITests
//
//  Created by André Haas on 28/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import UIKit

extension UIControl {
    func simulate(event: Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach({ (action) in
                (target as NSObject).perform(Selector(action))
            })
        }
    }

    func simulateTap(){
        simulate(event: .touchUpInside)
    }
}

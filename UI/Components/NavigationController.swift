//
//  NavigationController.swift
//  UI
//
//  Created by André Haas on 04/09/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import UIKit

public final class NavigationController: UINavigationController {
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    private func setup(){
        navigationBar.barTintColor = Color.primaryDark
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .black
    }
}

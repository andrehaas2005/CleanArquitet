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

    private var currectViewController: UIViewController?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    private func setup(){
        navigationBar.barTintColor = Color.primaryDark
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .black
    }

    public func setRootViewController(_ viewController: UIViewController){
        setViewControllers([viewController], animated: true)
        currectViewController = viewController
        hideBackButtonText()
    }

    public func pushViewController(_ viewController: UIViewController) {
        pushViewController(viewController, animated: true)
        currectViewController = viewController
        hideBackButtonText()
    }

    public func hideBackButtonText() {
        currectViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }
}

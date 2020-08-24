//
//  SignUpViewController.swift
//  UI
//
//  Created by André Haas on 24/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import UIKit
import Presentation

final class SignUpViewController: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
extension SignUpViewController: LoadingView {
    func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.startAnimating()
        }
    }
}

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
    @IBOutlet weak var saveButton: UIButton!

    var signUp: ((SignUpViewModel)->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure(){
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    @objc private func saveButtonTapped() {
        signUp?(SignUpViewModel(name: nil, email: nil, password: nil, passwordConfirmation: nil))
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

extension SignUpViewController: AlertView {
    func showMessage(viewModel: AlertViewModel) {

    }
}

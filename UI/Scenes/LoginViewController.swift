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

public final class LoginViewController: UIViewController, Storyboarded {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: RoundedTextField!
    @IBOutlet  weak var passwordTextField: RoundedTextField!

    public var login: ((LoginRequest)->Void)? = nil

    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure(){
        title = "4Dev"
        loginButton?.layer.cornerRadius = 5
        loginButton?.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @objc private func loginButtonTapped() {
        let viewModel = LoginRequest(email: emailTextField?.text, password: passwordTextField?.text)
        login?(viewModel)
    }
}
extension LoginViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
            loadingIndicator.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
            loadingIndicator.stopAnimating()
        }
    }
}

extension LoginViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alertViewController = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertViewController, animated: true)
    }
}

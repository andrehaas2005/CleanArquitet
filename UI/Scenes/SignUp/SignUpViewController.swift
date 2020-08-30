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

public final class SignUpViewController: UIViewController, Storyboarded {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!

    public var signUp: ((SignUpViewModel)->Void)?

    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure(){
        saveButton?.layer.cornerRadius = 5
        saveButton?.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @objc private func saveButtonTapped() {
        let viewModel = SignUpViewModel(name: nameTextField?.text,
                                        email: emailTextField?.text,
                                        password: passwordTextField?.text,
                                        passwordConfirmation: passwordConfirmationTextField?.text)
        signUp?(viewModel)
    }
}
extension SignUpViewController: LoadingView {
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

extension SignUpViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alertViewController = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertViewController, animated: true)
    }
}

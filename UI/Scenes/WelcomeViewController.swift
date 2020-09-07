//
//  SignUpViewController.swift
//  UI
//
//  Created by André Haas on 24/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import UIKit

public final class WelcomeViewController: UIViewController, Storyboarded {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!


    public var login: (()->Void)? = nil
    public var signUp: (()->Void)? = nil

    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure(){
        title = "4Dev"
        loginButton?.layer.cornerRadius = 5
        loginButton?.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        SignUpButton?.layer.cornerRadius = 5
        SignUpButton?.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @objc private func loginButtonTapped() {
        login?()
    }

    @objc private func signUpButtonTapped() {
//        signUp?()
    }
}

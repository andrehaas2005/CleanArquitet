//
//  RoundedTextField.swift
//  UI
//
//  Created by André Haas on 04/09/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import UIKit

class RoundedTextField: UITextField {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    private func setup(){
        self.layer.borderColor = Color.primaryLight.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
    }
}

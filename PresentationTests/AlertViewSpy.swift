//
//  AlertViewSpy.swift
//  PresentationTests
//
//  Created by André Haas on 31/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import Presentation

class AlertViewSpy: AlertView {
    var emit: ((AlertViewModel) -> Void)?

    func observe(completion: @escaping (AlertViewModel) -> Void) {
        self.emit = completion
    }

    func showMessage(viewModel: AlertViewModel) {
        self.emit?(viewModel)
    }
}

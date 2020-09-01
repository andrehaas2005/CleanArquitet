//
//  LoadingViewSpy.swift
//  PresentationTests
//
//  Created by André Haas on 31/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation
import Presentation

class LoadingViewSpy: LoadingView {
    var emit: ((LoadingViewModel) -> Void)?

    func observe(completion: @escaping (LoadingViewModel) -> Void) {
        self.emit = completion
    }

    func display(viewModel: LoadingViewModel) {
        self.emit?(viewModel)
    }
}

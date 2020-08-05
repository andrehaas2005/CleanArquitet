//
//  LoadingView.swift
//  Presentation
//
//  Created by André Haas on 05/08/20.
//  Copyright © 2020 André Haas. All rights reserved.
//

import Foundation

public protocol LoadingView {
    func display(viewModel: LoadingViewModel)
}

public struct LoadingViewModel: Equatable {
    public var isLoading: Bool

    public init(isLoading: Bool){
        self.isLoading = isLoading
    }
}

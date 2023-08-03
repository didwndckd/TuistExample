//
//  Home.swift
//  Home
//
//  Created by yjc on 2023/08/02.
//  Copyright © 2023 com.didwndckd. All rights reserved.
//

import Foundation
import HomePresentation
import HomeDomain
import HomeData

public struct Home {
    public static func module() -> HomeView {
        let repository = DefaultHomeRepository()
        let useCase = DefaultHomeUseCase(repository: repository)
        let viewModel = HomeViewModel(useCase: useCase)
        return HomeView(viewModel: viewModel)
    }
}

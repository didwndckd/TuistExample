//
//  HomeViewModel.swift
//  ProjectDescriptionHelpers
//
//  Created by yjc on 2023/08/01.
//

import Foundation
import HomeDomain
import HomeData

public final class HomeViewModel {
    private let useCase: HomeUseCase
    
    public init(useCase: HomeUseCase) {
        self.useCase = useCase
    }
}

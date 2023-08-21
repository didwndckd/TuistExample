//
//  HomeUseCase.swift
//  ProjectDescriptionHelpers
//
//  Created by yjc on 2023/08/01.
//

import Foundation
//import Firebase

public protocol HomeUseCase {}

public final class DefaultHomeUseCase: HomeUseCase {
    private let repository: HomeRepository
    public init(repository: HomeRepository) {
        self.repository = repository
//        FirebaseApp.configure()
    }
}

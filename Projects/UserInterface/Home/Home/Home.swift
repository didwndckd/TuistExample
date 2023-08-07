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

import UIKit
import SnapKit
import Moya

enum TestAPI: TargetType {
    var baseURL: URL { URL(string: "https://www.google.com")! }
    
    var path: String { "" }
    
    var method: Moya.Method { .get }
    
    var task: Moya.Task { .requestParameters(parameters: [:], encoding: URLEncoding.default) }
    
    var headers: [String : String]? { nil }
}

struct SnapKitTest {
    let view = UIView()
    
    func test() {
        view.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
    }
}

public struct Home {
    public static func module() -> HomeView {
        let repository = RemoteHomeRepository()
        let useCase = DefaultHomeUseCase(repository: repository)
        let viewModel = HomeViewModel(useCase: useCase)
        return HomeView(viewModel: viewModel)
    }
}

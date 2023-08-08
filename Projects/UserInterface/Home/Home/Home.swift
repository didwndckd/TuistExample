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

public enum TestAPI: TargetType {
    case test
    
    public var baseURL: URL { URL(string: "https://www.google.com")! }
    
    public var path: String { "" }
    
    public var method: Moya.Method { .get }
    
    public var task: Moya.Task { .requestParameters(parameters: [:], encoding: URLEncoding.default) }
    
    public var headers: [String : String]? { nil }
}

public struct SnapKitTest {
    public let view = UIView()
    public init() {}
    public func test() {
        let superView = UIView()
        superView.addSubview(view)
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

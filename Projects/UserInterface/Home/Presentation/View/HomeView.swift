//
//  HomeView.swift
//  ProjectDescriptionHelpers
//
//  Created by yjc on 2023/08/01.
//

import SwiftUI
import HomeDomain
import HomeData

public struct HomeView: View {
    private let viewModel: HomeViewModel
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            Text("Hello Home")
            Image("gorilla")
                .resizable()
                .frame(height: 100)
                .background(.green)
            Image("gorilla2")
                .resizable()
                .frame(height: 100)
                .background(.pink)
        }
    }
}

struct HomeView__Previews: PreviewProvider {
    static var previews: some View {
        let repo = DefaultHomeRepository()
        let useCase = DefaultHomeUseCase(repository: repo)
        let viewModel = HomeViewModel(useCase: useCase)
        return HomeView(viewModel: viewModel)
    }
}

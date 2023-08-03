//
//  HomeView.swift
//  ProjectDescriptionHelpers
//
//  Created by yjc on 2023/08/01.
//

import SwiftUI
import UserInterfaceKit

public struct HomeView: View {
    private let viewModel: HomeViewModel
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Text("Hello \(UserInterfaceKit().name) -> Home")
    }
}

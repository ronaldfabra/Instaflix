//
//  HomeViewBuilder.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 18/09/24.
//

import SwiftUI

struct HomeViewBuilder {
    static func make() -> some View {
        let viewModel = HomeViewModel()
        let view = HomeView(viewModel: viewModel)
        return view
    }
}

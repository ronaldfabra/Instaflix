//
//  SearchViewBuilder.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 18/09/24.
//

import SwiftUI

struct SearchViewBuilder {
    static func make() -> some View {
        let multiRepository = MultiRepository(network: Network.shared, database: InstaflixModelContainer.shared)
        let getSearchUseCase = GetSearchUseCase(repository: multiRepository)
        let viewModel = SearchViewModel(getSearchUseCase: getSearchUseCase)
        let view = SearchView(viewModel: viewModel)
        return view
    }
}

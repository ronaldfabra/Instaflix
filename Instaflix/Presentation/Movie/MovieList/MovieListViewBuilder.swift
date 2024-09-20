//
//  MovieListViewBuilder.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 18/09/24.
//

import SwiftUI

struct MovieListViewBuilder {
    static func make(orientation: Binding<UIDeviceOrientation> = .constant(.portrait)) -> some View {
        let network = Network.shared
        let database = InstaflixModelContainer.shared
        let movieRepository = MovieRepository(network: network, database: database)
        let getMovieByCategoryUseCase = GetMovieByCategoryUseCase(repository: movieRepository)
        let viewModel = MovieListViewModel(getMovieByCategoryUseCase: getMovieByCategoryUseCase)
        let view = MovieListView(viewModel: viewModel, orientation: orientation)
        return view
    }
}

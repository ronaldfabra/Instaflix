//
//  MyListViewBuilder.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 18/09/24.
//

import SwiftUI

struct MyListViewBuilder {
    static func make() -> some View {
        let movieRepository = MovieRepository(network: Network.shared, database: InstaflixModelContainer.shared)
        let serieRepository = SerieRepository(network: Network.shared, database: InstaflixModelContainer.shared)
        let getMyListMovieUseCase = GetMyListMovieUseCase(repository: movieRepository)
        let getMyListSerieUseCase = GetMyListSerieUseCase(repository: serieRepository)
        let viewModel = MyListViewModel(getMyListMovieUseCase: getMyListMovieUseCase,
                                        getMyListSerieUseCase: getMyListSerieUseCase)
        let view = MyListView(viewModel: viewModel)
        return view
    }
}

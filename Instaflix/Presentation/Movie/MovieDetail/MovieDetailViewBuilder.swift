//
//  MovieDetailViewBuilder.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 18/09/24.
//

import SwiftUI

struct MovieDetailViewBuilder {
    static func make(
        movie: any ItemInformationProtocol,
        orientation: Binding<UIDeviceOrientation> = .constant(.portrait),
        showBackButton: Bool = false,
        onMyListChange: (() -> Void)? = nil,
        onBackButtonPressed: (() -> Void)? = nil,
        onClosePressed: (() -> Void)? = nil
    ) -> some View {
        let movieRepository = MovieRepository(network: Network.shared, database: InstaflixModelContainer.shared)
        let getMovieByIdUseCase = GetMovieDetailByIdUseCase(repository: movieRepository)
        let similarRepository = SimilarRepository(network: Network.shared, database: InstaflixModelContainer.shared)
        let getSimilarMoviesByIdUseCase = GetSimilarMoviesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepository(network: Network.shared)
        let getMovieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        let multiRepository = MultiRepository(network: Network.shared, database: InstaflixModelContainer.shared)
        let setFavoriteMovieUseCase = SetFavoriteUseCase(repository: multiRepository)
        let itemInformationViewModel = ItemInformationViewModel(setFavoriteMovieUseCase: setFavoriteMovieUseCase, itemModel: movie, mediaType: .movie)
        let viewModel = MovieDetailViewModel(
            getMovieByIdUseCase: getMovieByIdUseCase,
            getSimilarMoviesByIdUseCase: getSimilarMoviesByIdUseCase,
            getMovieVideoByIdUseCase: getMovieVideoByIdUseCase,
            movie: movie
        )
        let view = MovieDetailView(
            viewModel: viewModel,
            itemInformationViewModel: itemInformationViewModel,
            orientation: orientation,
            showBackButton: showBackButton,
            onMyListChange: onMyListChange,
            onBackButtonPressed: onBackButtonPressed,
            onClosePressed: onClosePressed
        )
        return view
    }
}

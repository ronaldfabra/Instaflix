//
//  SerieDetailViewBuilder.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 18/09/24.
//

import SwiftUI

struct SerieDetailViewBuilder {
    static func make(
        serie: any ItemInformationProtocol,
        orientation: Binding<UIDeviceOrientation> = .constant(.portrait),
        showBackButton: Bool = false,
        onMyListChange: (() -> Void)? = nil,
        onBackButtonPressed: (() -> Void)? = nil,
        onClosePressed: (() -> Void)? = nil
    ) -> some View {
        let serieRepository = SerieRepository(network: Network.shared, database: InstaflixModelContainer.shared)
        let getSerieByIdUseCase = GetSerieDetailByIdUseCase(repository: serieRepository)
        let similarRepository = SimilarRepository(network: Network.shared, database: InstaflixModelContainer.shared)
        let getSimilarSeriesByIdUseCase = GetSimilarSeriesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepository(network: Network.shared)
        let getSerieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        let multiRepository = MultiRepository(network: Network.shared, database: InstaflixModelContainer.shared)
        let setFavoriteMovieUseCase = SetFavoriteUseCase(repository: multiRepository)
        let itemInformationViewModel = ItemInformationViewModel(setFavoriteMovieUseCase: setFavoriteMovieUseCase, itemModel: serie, mediaType: .serie)
        let viewModel = SerieDetailViewModel(
            getSerieByIdUseCase: getSerieByIdUseCase,
            getSimilarSeriesByIdUseCase: getSimilarSeriesByIdUseCase,
            getSerieVideoByIdUseCase: getSerieVideoByIdUseCase,
            serie: serie
        )
        let view = SerieDetailView(
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

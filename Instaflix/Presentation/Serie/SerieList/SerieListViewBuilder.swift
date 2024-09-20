//
//  SerieListViewBuilder.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 18/09/24.
//

import SwiftUI

struct SerieListViewBuilder {
    static func make(orientation: Binding<UIDeviceOrientation> = .constant(.portrait)) -> some View {
        let serieRepository = SerieRepository(network: Network.shared, database: InstaflixModelContainer.shared)
        let getSerieByCategoryUseCase = GetSerieByCategoryUseCase(repository: serieRepository)
        let viewModel = SerieListViewModel(getSerieByCategoryUseCase: getSerieByCategoryUseCase)
        let view = SerieListView(viewModel: viewModel, orientation: orientation)
        return view
    }
}

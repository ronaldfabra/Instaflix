//
//  SerieListView.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 13/09/24.
//

import SwiftUI

struct SerieListView: View {

    @Binding var orientation: UIDeviceOrientation
    @EnvironmentObject var bannerViewModel: BannerViewModel
    @State private var viewModel: SerieListViewModel

    init(viewModel: SerieListViewModel, orientation: Binding<UIDeviceOrientation> = .constant(.portrait)) {
        self.viewModel = viewModel
        self._orientation = orientation
    }

    var body: some View {
        contentView
            .task {
                await viewModel.fetchAllSeries()
            }
            .fullScreenCover(isPresented: $viewModel.showSerieDetailView, content: {
                serieDetailView
            })
            .onRotate { newOrientation in
                orientation = newOrientation
            }
            .onChange(of: viewModel.error) { _, error in
                if error != .none {
                    bannerViewModel.setBanner(banner: .error(message: error.errorDescription))
                }
            }
    }
}

// MARK: content view
extension SerieListView {
    private var contentView: some View {
        ZStack {
            Color.instaflixBlack.ignoresSafeArea()
            if viewModel.showSkeleton {
                skeletonView
            } else {
                listView
            }
        }
        .background(.instaflixBlack)
    }
}

// MARK: skeletonView
extension SerieListView {
    private var skeletonView: some View {
        VStack {
            CategorySectionLoadingView()
            CategorySectionLoadingView()
            CategorySectionLoadingView()
        }
        .disabled(true)
    }
}

// MARK: listView
extension SerieListView {
    private var listView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(Array(viewModel.categories.enumerated()), id: \.offset) { _, category in
                    CategorySectionView(
                        category: category,
                        onItemPressed: { movie in
                            viewModel.onSeriePressed(movie)
                        }, onPaginateIfNeeded: {
                            Task {
                                await viewModel.onPaginateIfNeeded(category: category)
                            }
                        })
                    .foregroundStyle(Color.instaflixBlack)
                }
            }
        }
    }
}

// MARK: serie Detail view
extension SerieListView {
    private var serieDetailView: some View {
        if let serieSelected = viewModel.serieSelected {
            AnyView(SerieDetailViewBuilder.make(
                serie: serieSelected,
                orientation: $orientation,
                onClosePressed: {
                    viewModel.showSerieDetailView.toggle()
                }
            ))
        } else {
            AnyView(EmptyView())
        }
    }
}

#Preview {
    SerieListViewBuilder.make()
        .environmentObject(BannerViewModel())
}

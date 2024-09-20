//
//  MovieListView.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 13/09/24.
//

import SwiftUI

struct MovieListView: View {

    @Binding var orientation: UIDeviceOrientation
    @EnvironmentObject var bannerViewModel: BannerViewModel
    @State private var viewModel: MovieListViewModel

    init(viewModel: MovieListViewModel, orientation: Binding<UIDeviceOrientation> = .constant(.portrait)) {
        self.viewModel = viewModel
        self._orientation = orientation
    }

    var body: some View {
        contentView
            .task {
                await viewModel.fetchAllMovies()
            }
            .fullScreenCover(isPresented: $viewModel.showMovieDetailView, content: {
                movieDetailView
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

// MARK: skeletonview
extension MovieListView {
    private var contentView: some View {
        VStack {
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

// MARK: skeletonview
extension MovieListView {
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
extension MovieListView {
    private var listView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(Array(viewModel.categories.enumerated()), id: \.offset) { _, category in
                    CategorySectionView(
                        category: category,
                        onItemPressed: { movie in
                            viewModel.onMoviePressed(movie)
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

// MARK: movie Detail view
extension MovieListView {
    private var movieDetailView: some View {
        if let movieSelected = viewModel.movieSelected {
            AnyView(MovieDetailViewBuilder.make(
                movie: movieSelected,
                orientation: $orientation,
                onClosePressed: {
                    viewModel.showMovieDetailView.toggle()
                }
            ))
        } else {
            AnyView(EmptyView())
        }
    }
}

#Preview {
    MovieListViewBuilder.make()
        .environmentObject(BannerViewModel())
}

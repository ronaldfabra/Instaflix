//
//  HomeView.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 13/09/24.
//

import SwiftUI

struct HomeView: View {

    typealias Values = HomeViewConstants.Values
    typealias Assets = HomeViewConstants.Assets
    typealias Dimens = HomeViewConstants.Dimens
    typealias Strings = HomeViewConstants.Strings

    @State var orientation: UIDeviceOrientation = .portrait
    @State private var viewModel: HomeViewModel
    @State var scrollViewOffset: CGFloat = .zero
    @State var fullHeaderSize: CGSize = .zero

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack(alignment: .top) {
            Color.instaflixBlack.ignoresSafeArea()
            bodyView
            headerView
        }
        .foregroundStyle(.instaflixWhite)
        .toolbar(.hidden, for: .navigationBar)
        .fullScreenCover(isPresented: $viewModel.showSearchView, content: {
            SearchViewBuilder.make()
        })
        .onRotate { newOrientation in
            orientation = newOrientation
        }
    }
}

// MARK: header view
extension HomeView {
    var headerView: some View {
        VStack(spacing: .zero) {
            navigationBarView
                .padding(.horizontal, Dimens.spacing16)
            filtersView
                .padding(.top, Dimens.spacing16)
        }
        .padding(.bottom, Dimens.spacing8)
        .background(
            ZStack {
                if scrollViewOffset < -70 {
                    Rectangle()
                        .fill(Color.clear)
                        .background(.ultraThinMaterial)
                        .brightness(Values.backgroundHeaderBrightness)
                        .ignoresSafeArea()
                }
            }
        )
        .animation(.smooth, value: scrollViewOffset)
        .readingFrame { frame in
            fullHeaderSize = frame.size
        }
    }

    var navigationBarView: some View {
        HStack(spacing: .zero) {
            Text(Strings.forYou)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)

            Image(systemName: Assets.searchIcon)
                .font(.title2)
                .onTapGesture {
                    viewModel.showSearchView = true
                }
        }
    }
}

// MARK: filters view
extension HomeView {
    var filtersView: some View {
        VStack {
            if scrollViewOffset > -20 {
                FilterBarView(
                    filters: viewModel.filters,
                    selectedFilter: $viewModel.selectedFilter,
                    onClosePressed: {
                        viewModel.selectedFilter = nil
                    })
                .padding(.top, Dimens.spacing16)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .padding(.bottom, Dimens.spacing8)
        .animation(.smooth, value: scrollViewOffset)
        .readingFrame { frame in
            if fullHeaderSize == .zero {
                fullHeaderSize = frame.size
            }
        }
    }
}

// MARK: body view
extension HomeView {
    var bodyView: some View {
        ScrollViewWithOnScrollChanged(
            .vertical,
            showsIndicators: false,
            content: {
                VStack(spacing: Dimens.spacing8) {
                    Rectangle()
                        .opacity(.zero)
                        .frame(height: fullHeaderSize.height)
                    VStack {
                        if let selectedFilter = viewModel.selectedFilter {
                            switch selectedFilter.title {
                                case MediaType.movie.filterTitle:
                                    AnyView(MovieListViewBuilder.make(orientation: $orientation))
                                case MediaType.serie.filterTitle:
                                    AnyView(SerieListViewBuilder.make(orientation: $orientation))
                                default:
                                    EmptyView()
                            }
                        }
                    }
                    .padding(.bottom, Dimens.spacing10)
                }
            },
            onScrollChanged: { offset in
                scrollViewOffset = min(.zero, offset.y)
            }
        )
    }
}


#Preview {
    HomeViewBuilder.make()
        .environmentObject(BannerViewModel())
}


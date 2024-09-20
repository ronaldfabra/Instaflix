//
//  MyListView.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import SwiftUI

struct MyListView: View {

    typealias Dimens = MyListViewConstants.Dimens
    typealias Strings = MyListViewConstants.Strings
    typealias Values = MyListViewConstants.Values

    @State var orientation: UIDeviceOrientation = .portrait
    @EnvironmentObject var bannerViewModel: BannerViewModel
    @State private var viewModel:  MyListViewModel
    @State var scrollViewOffset: CGFloat = .zero
    @State var fullHeaderSize: CGSize = .zero
    @State private var searchText = ""

    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: Dimens.cellWidth)),
        GridItem(.adaptive(minimum: Dimens.cellWidth)),
        GridItem(.adaptive(minimum: Dimens.cellWidth))
    ]

    init(viewModel: MyListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        contentView
            .onAppear {
                viewModel.fetchAllData()
            }
            .fullScreenCover(isPresented: $viewModel.showSerieDetailView) {
                serieDetaiView
            }
            .fullScreenCover(isPresented: $viewModel.showMovieDetailView) {
                movieDetaiView
            }
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

// MARK: contentView
extension MyListView {
    private var contentView: some View {
        ZStack(alignment: .top) {
            Color.instaflixBlack.ignoresSafeArea()
            if viewModel.showLoading {
                skeletonView
            } else {
                bodyView
            }
            headerView
        }
        .foregroundStyle(.instaflixWhite)
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: body view
extension MyListView {
    private var bodyView: some View {
        VStack(spacing: .zero) {
            if viewModel.movieList.isEmpty && viewModel.serieList.isEmpty {
                emptyState
            } else {
                ScrollViewWithOnScrollChanged(
                    .vertical,
                    showsIndicators: false,
                    content: {
                        bodyContentView
                    },
                    onScrollChanged: { offset in
                        scrollViewOffset = min(.zero, offset.y)
                    }
                )
            }
        }
    }

    private  var bodyContentView: some View {
        VStack(spacing: Dimens.spacing8) {
            Rectangle()
                .opacity(.zero)
                .frame(height: fullHeaderSize.height)
            VStack {
                ScrollView {
                    VStack(spacing: Dimens.spacingBetweenSections) {
                        myMoviesSection
                        mySeriesSection
                    }
                }
            }
            .padding(.horizontal, Dimens.generaHorizontalPadding)
        }
    }
}

// MARK: myMoviesSection
extension MyListView {
    private var emptyState: some View {
        VStack {
            Spacer()
            VStack(alignment: .center, spacing: Dimens.spacing20) {
                VStack(alignment: .center, spacing: Dimens.spacing10) {
                    Text(Strings.emptyStateTitle)
                        .font(.title)
                        .fontWeight(.bold)
                    Text(Strings.emptyStateDescription)
                        .font(.headline)
                        .fontWeight(.medium)
                }
                .multilineTextAlignment(.center)
                HStack(spacing: .zero) {
                    Text(Strings.addFavoriteHelper) +
                    Text(Image(systemName: InstaflixContants.Icons.plus)) +
                    Text(Strings.button)
                }
                .font(.callout)
            }
            Spacer()
        }
    }
}

// MARK: myMoviesSection
extension MyListView {
    private var myMoviesSection: some View {
        VStack {
            if !viewModel.movieList.isEmpty {
                VStack(alignment: .leading) {
                    Text(MediaType.movie.filterTitle.capitalized)
                        .fontWeight(.bold)
                    LazyVGrid(columns: columns, spacing: Dimens.spacingBetweenCells) {
                        ForEach(viewModel.movieList) { model in
                            ItemCell(
                                model: model,
                                isRecentlyAdded: InstaflixUtils.isRecentlyAdded(dateStr: model.releaseDate ?? .empty),
                                cellWidth: Dimens.cellWidth
                            )
                            .clipShape(.rect(cornerRadius: Dimens.cellCornerRadius))
                            .onTapGesture {
                                viewModel.onMoviePressed(model)
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: mySeriesSection
extension MyListView {
    private var mySeriesSection: some View {
        VStack {
            if !viewModel.serieList.isEmpty {
                VStack(alignment: .leading) {
                    Text(MediaType.serie.filterTitle.capitalized)
                        .fontWeight(.bold)
                    LazyVGrid(columns: columns, spacing: Dimens.spacingBetweenCells) {
                        ForEach(viewModel.serieList) { model in
                            ItemCell(
                                model: model,
                                isRecentlyAdded: InstaflixUtils.isRecentlyAdded(dateStr: model.releaseDate ?? .empty),
                                cellWidth: Dimens.cellWidth
                            )
                            .clipShape(.rect(cornerRadius: Dimens.cellCornerRadius))
                            .onTapGesture {
                                viewModel.onSeriePressed(model)
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: serieDetaiView
extension MyListView {
    private var serieDetaiView: some View {
        if let serie = viewModel.serieSelected {
            AnyView(SerieDetailViewBuilder.make(
                serie: serie,
                orientation: $orientation,
                onMyListChange: {
                    viewModel.fetchSeries()
                },
                onClosePressed: {
                    viewModel.showSerieDetailView.toggle()
                }
            ))
        } else {
            AnyView(EmptyView())
        }
    }
}

// MARK: movieDetaiView
extension MyListView {
    private var movieDetaiView: some View {
        if let movie = viewModel.movieSelected {
            AnyView(MovieDetailViewBuilder.make(
                movie: movie,
                orientation: $orientation,
                onMyListChange: {
                    viewModel.fetchMovies()
                },
                onClosePressed: {
                    viewModel.showMovieDetailView.toggle()
                }
            ))
        } else {
            AnyView(EmptyView())
        }
    }
}

// MARK: header view
extension MyListView {
    private var headerView: some View {
        HStack(spacing: Dimens.spacing10) {
            Image(InstaflixContants.Icons.appLogo)
                .resizable()
                .frame(width: Dimens.logoWitth, height: Dimens.logoHeight)
            Text(Strings.myList)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .fontWeight(.bold)
        }
        .padding(.bottom, Dimens.spacing8)
        .padding(.horizontal, Dimens.generaHorizontalPadding)
        .background(
            ZStack {
                if scrollViewOffset < Values.maximumOfssetToDisplayTheBackgroundHeader {
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
}

// MARK: skeletonView
extension MyListView {
    private var skeletonView: some View {
        VStack(spacing: .zero) {
            CategorySectionLoadingView()
            CategorySectionLoadingView()
            Spacer()
        }
    }
}

#Preview {
    MyListViewBuilder.make()
        .environmentObject(BannerViewModel())
}


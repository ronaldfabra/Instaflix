//
//  MovieDetailView.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 13/09/24.
//

import SwiftUI

struct MovieDetailView: View {

    typealias Dimens = MovieDetailViewConstants.Dimens
    typealias Strings = MovieDetailViewConstants.Strings

    @Binding var orientation: UIDeviceOrientation
    @EnvironmentObject var bannerViewModel: BannerViewModel

    @State private var viewModel: MovieDetailViewModel
    @State private var itemInformationViewModel: ItemInformationViewModel
    @State private var playButtonActive: Bool = false
    private var showBackButton: Bool
    private var onMyListChange: (() -> Void)?
    private var onBackButtonPressed: (() -> Void)?
    private var onClosePressed: (() -> Void)?

    private var columns: [GridItem] = [
        GridItem(.adaptive(minimum: Dimens.cellWidth)),
        GridItem(.adaptive(minimum: Dimens.cellWidth)),
        GridItem(.adaptive(minimum: Dimens.cellWidth))
    ]

    init(
        viewModel: MovieDetailViewModel,
        itemInformationViewModel: ItemInformationViewModel,
        orientation: Binding<UIDeviceOrientation> = .constant(.portrait),
        showBackButton: Bool = false,
        onMyListChange: (() -> Void)? = nil,
        onBackButtonPressed: (() -> Void)? = nil,
        onClosePressed: (() -> Void)? = nil
    ) {
        self.viewModel = viewModel
        self.itemInformationViewModel = itemInformationViewModel
        self._orientation = orientation
        self.showBackButton = showBackButton
        self.onMyListChange = onMyListChange
        self.onBackButtonPressed = onBackButtonPressed
        self.onClosePressed = onClosePressed
    }

    var body: some View {
        contentView
            .task {
                await viewModel.fetchAllInformation(movieId: viewModel.currentMovie?.id)
            }
            .sheet(isPresented: $playButtonActive, content: {
                trailerVideoView
            })
            .navigationBarBackButtonHidden()
            .foregroundStyle(.instaflixWhite)
            .redacted(reason: viewModel.showLoading ? .placeholder : [])
            .allowsHitTesting(!viewModel.showLoading)
            .navigate(to: similarMovieDetailView, when: $viewModel.showSimilarMovieDetailView)
            .onChange(of: viewModel.showLoading) { _, newValue in
                if !newValue {
                    itemInformationViewModel.updateItemModel(itemModel: viewModel.currentMovie)
                }
            }
            .onRotate { newOrientation in
                orientation = newOrientation
            }
            .onChange(of: viewModel.error) { _, error in
                if error != .none {
                    bannerViewModel.setBanner(banner: .error(message: error.errorDescription))
                }
            }
            .errorHandlerModifier()
    }
}

// MARK: header
extension MovieDetailView {
    private var contentView: some View {
        ZStack {
            Color.instaflixBlack.ignoresSafeArea()
            VStack(spacing: .zero) {
                header
                bodyView
            }
            .if(orientation.isLandscape || orientation == .portraitUpsideDown) { view in
                ScrollView(.vertical) {
                    view
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

// MARK: header
extension MovieDetailView {
    private var bodyView: some View {
        ScrollView(.vertical) {
            VStack(spacing: Dimens.spacing10) {
                ItemInformationView(
                    viewModel: itemInformationViewModel,
                    playButtonActive: $playButtonActive,
                    isTraierAvailable: viewModel.getVideoId() != nil,
                    onMyListChange: onMyListChange
                )
                moreLikeThisSection
            }
            .padding(.horizontal, Dimens.spacing10)
        }
        .scrollIndicators(.hidden)
        .scrollDisabled(orientation.isLandscape || orientation == .portraitUpsideDown)
    }
}

// MARK: header
extension MovieDetailView {
    private var header: some View {
        ZStack(alignment: .topLeading) {
            BackdropImageView(filePath: viewModel.currentMovie?.backdropPath)
            NavigationHeaderView(
                showBackButton: showBackButton,
                onBackPressed: onBackButtonPressed,
                onClosePressed: onClosePressed
            )
        }
    }
}

// MARK: moreLikeThis Section
extension MovieDetailView {
    private var moreLikeThisSection: some View {
        VStack {
            if !viewModel.similarList.isEmpty {
                VStack(alignment: .leading) {
                    Text(Strings.moreLikeThis.capitalized)
                        .fontWeight(.bold)
                    LazyVGrid(columns: columns, spacing: Dimens.spacingBetweenSimilarCells) {
                        ForEach(viewModel.similarList) { model in
                            ItemCell(
                                model: model,
                                isRecentlyAdded: InstaflixUtils.isRecentlyAdded(dateStr: model.releaseDate ?? .empty),
                                cellWidth: Dimens.cellWidth,
                                cellHeight: Dimens.cellHeight
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

// MARK: similar movie detail
extension MovieDetailView {
    private var similarMovieDetailView: some View {
        if let nextMovie = viewModel.nextMovie {
            AnyView(
                MovieDetailViewBuilder.make(
                    movie: nextMovie,
                    orientation: $orientation,
                    showBackButton: true,
                    onMyListChange: onMyListChange,
                    onBackButtonPressed: {
                        viewModel.showSimilarMovieDetailView = false
                    },
                    onClosePressed: onClosePressed
                )
            )
        } else {
            AnyView(EmptyView())
        }
    }
}

// MARK: trailer video view
extension MovieDetailView {
    private var trailerVideoView: some View {
        VStack {
            if let videoId = viewModel.getVideoId() {
                ZStack {
                    Color.instaflixBlack.ignoresSafeArea()
                    ZStack(alignment: .topLeading) {
                        YouTubeView(videoId: videoId)
                        NavigationHeaderView(onClosePressed:  {
                            playButtonActive.toggle()
                        })
                    }
                }
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    MovieDetailViewBuilder.make(movie: MovieDomainModel.mockData())
        .environmentObject(BannerViewModel())
}

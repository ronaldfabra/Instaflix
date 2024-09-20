//
//  SearchView.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 13/09/24.
//

import SwiftUI

struct SearchView: View {

    typealias Values = SearchViewConstants.Values
    typealias Dimens = SearchViewConstants.Dimens
    typealias Strings = SearchViewConstants.Strings

    @State var orientation: UIDeviceOrientation = .portrait
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var bannerViewModel: BannerViewModel
    @State private var viewModel: SearchViewModel
    @State private var searchText = ""

    private var columns: [GridItem] = [
        GridItem(.adaptive(minimum: Dimens.cellWidth)),
        GridItem(.adaptive(minimum: Dimens.cellWidth)),
        GridItem(.adaptive(minimum: Dimens.cellWidth))
    ]

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        contentView
            .fullScreenCover(isPresented: $viewModel.showSerieDetailView) {
                serieDetailView
            }
            .fullScreenCover(isPresented: $viewModel.showMovieDetailView) {
                movieDetailView
            }
            .foregroundStyle(.instaflixWhite)
            .textInputAutocapitalization(.never)
            .onChange(of: searchText) {
                Task {
                    await viewModel.fetchBy(query: searchText)
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

// MARK: contentView
extension SearchView {
    private var contentView: some View {
        ZStack(alignment: .topLeading) {
            Color.instaflixBlack.ignoresSafeArea()
            VStack {
                Spacer(minLength: Dimens.topSpace)
                NavigationStack {
                    ZStack {
                        Color.instaflixBlack.ignoresSafeArea()
                        bodyView
                    }
                }
            }
            headerView
        }
    }
}

// MARK: header view
extension SearchView {
    var headerView: some View {
        VStack(spacing: .zero) {
            navigationBarView
                .padding(.horizontal, Dimens.spacing16)
        }
    }

    var navigationBarView: some View {
        HStack(spacing: .zero) {
            Text(Strings.search)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)

            Circle()
                .fill(.instaflixBlack.opacity(0.4))
                .overlay(
                    Image(systemName: InstaflixContants.Icons.close)
                        .offset(y: Values.one)
                )
                .frame(width: Dimens.closeButtonSize, height: Dimens.closeButtonSize)
                .onTapGesture {
                    dismiss()
                }
        }
    }
}

// MARK: bodyView
extension SearchView {
    private var bodyView: some View {
        VStack(alignment: .leading) {
            Text(Strings.tvShowsAndMovies)
                .fontWeight(.bold)
            ScrollView {
                LazyVGrid(columns: columns, spacing: Dimens.spacingBetweenCells) {
                    ForEach(Array(viewModel.list.enumerated()), id: \.offset) { index, model in
                        ItemCell(
                            model: model,
                            isRecentlyAdded: InstaflixUtils.isRecentlyAdded(dateStr: model.releaseDate ?? .empty),
                            cellWidth: Dimens.cellWidth,
                            cellHeight: Dimens.cellHeight
                        )
                        .clipShape(.rect(cornerRadius: Dimens.cellCornerRadius))
                        .onAppear {
                            if model.id == viewModel.list.last?.id {
                                Task {
                                    await viewModel.fetchBy(query: searchText)
                                }
                            }
                        }
                        .onTapGesture {
                            viewModel.onItemPressed(model)
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: Strings.searchPlaceholder)
        }
        .padding(.horizontal, Dimens.generaHorizontalPadding)
        .padding(.vertical, Dimens.spacing10)
    }
}

// MARK: serieDetailView
extension SearchView {
    private var serieDetailView: some View {
        if let serieSelected = viewModel.mediaSelected {
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

// MARK: movieDetailView
extension SearchView {
    private var movieDetailView: some View {
        if let movieSelected = viewModel.mediaSelected {
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
    SearchViewBuilder.make()
        .environmentObject(BannerViewModel())
}

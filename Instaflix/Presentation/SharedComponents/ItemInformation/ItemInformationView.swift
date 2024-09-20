//
//  ItemInformationView.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import SwiftUI

struct ItemInformationView: View {

    typealias Values = ItemInformationViewConstants.Values
    typealias Dimens = ItemInformationViewConstants.Dimens
    typealias Assets = ItemInformationViewConstants.Assets
    typealias Strings = ItemInformationViewConstants.Strings

    @EnvironmentObject var bannerViewModel: BannerViewModel
    @State private var viewModel: ItemInformationViewModel
    @Binding var playButtonActive: Bool
    var isTraierAvailable: Bool
    var onMyListChange: (() -> Void)? = nil

    init(
        viewModel: ItemInformationViewModel,
        playButtonActive: Binding<Bool>,
        isTraierAvailable: Bool = false,
        onMyListChange: (() -> Void)? = nil
    ) {
        self.viewModel = viewModel
        self._playButtonActive = playButtonActive
        self.isTraierAvailable = isTraierAvailable
        self.onMyListChange = onMyListChange
    }

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: Dimens.spacing10) {
                itemInformation
                playButton
                    .if(!isTraierAvailable) { content in
                        content.hidden(true, remove: true)
                    }
            }
            .padding(.top, Dimens.spacing10)
            HStack {
                VStack(alignment: .leading, spacing: Dimens.spacing4) {
                    Text(viewModel.itemModel?.overview ?? .empty)
                        .if(!viewModel.shouldDisplayText(text: viewModel.itemModel?.overview)) { content in
                            content.hidden(true, remove: true)
                        }
                    HStack(alignment: .top) {
                        Text(Strings.genres)
                            .fontWeight(.bold)
                        Text((viewModel.itemModel?.mediaGenres ?? []).joined(separator: ", "))
                    }.if((viewModel.itemModel?.mediaGenres ?? []).isEmpty) { content in
                        content.hidden(true, remove: true)
                    }
                    HStack(alignment: .top) {
                        Text(Strings.spokenLanguages)
                            .fontWeight(.bold)
                        Text((viewModel.itemModel?.spokenLanguages?.map { $0.englishName } ?? []).joined(separator: ", "))
                    }.if((viewModel.itemModel?.spokenLanguages ?? []).isEmpty) { content in
                        content.hidden(true, remove: true)
                    }
                }
                .font(.callout)
                Spacer()
            }
            .foregroundStyle(Color.instaflixWhite)
            actionButtons
        }
        .foregroundStyle(.instaflixWhite)
        .redacted(reason: viewModel.showLoading ? .placeholder : [])
        .allowsHitTesting(!viewModel.showLoading)
        .onChange(of: viewModel.error) { _, error in
            bannerViewModel.setBanner(banner: .error(message: error.errorDescription, isPersistent: true))
        }
    }
}


// MARK: item image
extension ItemInformationView {
    var itemInformation: some View {
        VStack(alignment: .leading, spacing: Dimens.spacing10) {
            Text(viewModel.itemModel?.title ?? .empty)
                .if(!viewModel.shouldDisplayText(text: viewModel.itemModel?.title)) { content in
                    content.hidden(true, remove: true)
                }
                .font(.title2)
                .fontWeight(.bold)
            HStack {
                Text(viewModel.itemModel?.releaseYear ?? .empty)
                    .font(.subheadline)
                    .if(!viewModel.shouldDisplayText(text: viewModel.itemModel?.releaseYear)) { content in
                        content.hidden(true, remove: true)
                    }
                Text(viewModel.getAgeRecommended(itemModel: viewModel.itemModel))
                    .font(.caption2)
                    .padding(Dimens.spacing4)
                    .background(Color.instaflixLightGray)
                let itemDuration = viewModel.getItemDuration(itemModel: viewModel.itemModel, mediaType: viewModel.mediaType)
                Text(itemDuration)
                    .font(.subheadline)
                    .if(!viewModel.shouldDisplayText(text: itemDuration)) { content in
                        content.hidden(true, remove: true)
                    }
            }
        }
    }

    var playButton: some View {
        Button(action: {
            playButtonActive.toggle()
        }, label: {
            HStack {
                ZStack {
                    Image(systemName:  Assets.playIcon)
                        .opacity(playButtonActive ? .zero : Values.one)

                    Image(systemName: Assets.pauseIcon)
                        .opacity(playButtonActive ? Values.one : .zero)
                }
                Text(playButtonActive ? Strings.stop : Strings.play)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Dimens.spacing8)
            .fontWeight(.bold)
            .foregroundStyle(.instaflixBlack)
            .background(Color.instaflixWhite)
        })
        .animation(.bouncy, value: playButtonActive)
        .clipShape(.buttonBorder)
    }

    var actionButtons: some View {
        HStack(spacing: Dimens.spacingBetweenActionButtons) {
            MyListButton(isOnMyList: viewModel.itemModel?.isFavorite ?? false) { isFavorite in
                viewModel.setFavorite(itemId: viewModel.itemModel?.id,
                                      isFavorite: isFavorite,
                                      mediaType: viewModel.mediaType)
                onMyListChange?()
            }
            ShareButton(urlString: viewModel.itemModel?.homepage ?? String.empty)
        }
    }
}

#Preview {
    ZStack {
        Color.instaflixBlack.ignoresSafeArea()
        ItemInformationView(
            viewModel: .init(
                setFavoriteMovieUseCase: SetFavoriteUseCase(
                    repository: MultiRepository(
                        network: Network.shared,
                        database: InstaflixModelContainer.shared
                    )
                ),
                itemModel: SerieDetailDomainModel.mockData(),
                mediaType: .serie),
            playButtonActive: .constant(false)
        )
    }
}

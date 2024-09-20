//
//  ItemInformationViewModel.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

@Observable
class ItemInformationViewModel: ObservableObject {
    private let setFavoriteMovieUseCase: SetFavoriteUseCaseProtocol
    var itemModel: (any ItemInformationProtocol)?
    var showLoading: Bool = false
    var error: NetworkErrorType = .none
    let mediaType: MediaType
    
    init(
        setFavoriteMovieUseCase: SetFavoriteUseCaseProtocol,
        itemModel: (any ItemInformationProtocol)?,
        mediaType: MediaType
    ) {
        self.itemModel = itemModel
        self.mediaType = mediaType
        self.setFavoriteMovieUseCase = setFavoriteMovieUseCase
    }
}

extension ItemInformationViewModel {
    func getAgeRecommended(itemModel: (any ItemInformationProtocol)?) -> String {
        (itemModel?.adult ?? false) ? ItemInformationViewConstants.Strings.adultAgeRecommended : ItemInformationViewConstants.Strings.generalAgeRecommended
    }

    func shouldDisplayText(text: String?) -> Bool {
        !(text ?? .empty).isEmpty
    }

    func getItemDuration(itemModel: (any ItemInformationProtocol)?, mediaType: MediaType) -> String {
        switch mediaType {
            case .movie:
                guard let runtime = itemModel?.runtime,
                      runtime > .zero,
                      let timeFormatted = InstaflixUtils.convertMinutesToHours(minutes: runtime) else { return  .empty }
                return timeFormatted
            case .serie:
                guard let numberOfSeasons = itemModel?.numberOfSeasons, numberOfSeasons > .zero else { return  .empty }
                return String(format: ItemInformationViewConstants.Strings.seasons, numberOfSeasons)
        }
    }

    func setFavorite(itemId: Int?, isFavorite: Bool, mediaType: MediaType) {
        guard let itemId else { return }
        setFavoriteMovieUseCase.execute(itemId: itemId, isFavorite: isFavorite, mediaType: mediaType)
        itemModel?.isFavorite = isFavorite
    }

    func updateItemModel(itemModel: (any ItemInformationProtocol)?) {
        self.itemModel = itemModel
    }
}

//
//  SetFavoriteMovieUseCase.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Foundation

protocol SetFavoriteUseCaseProtocol {
    func execute(itemId: Int, isFavorite: Bool, mediaType: MediaType)
}

class SetFavoriteUseCase: SetFavoriteUseCaseProtocol {
    let repository: MultiRepositoryProtocol

    init(repository: MultiRepositoryProtocol) {
        self.repository = repository
    }

    func execute(itemId: Int, isFavorite: Bool, mediaType: MediaType) {
        repository.setFavorite(itemId: itemId, isFavorite: isFavorite, mediaType: mediaType)
    }
}

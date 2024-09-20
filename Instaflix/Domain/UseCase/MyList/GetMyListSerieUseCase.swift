//
//  GetMyListSerieUseCase.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Foundation

protocol GetMyListSerieUseCaseProtocol {
    func execute() -> [SerieDomainModel]
}

class GetMyListSerieUseCase: GetMyListSerieUseCaseProtocol {
    let repository: SerieRepositoryProtocol

    init(repository: SerieRepositoryProtocol) {
        self.repository = repository
    }

    func execute() -> [SerieDomainModel] {
        repository.getAllFavoritesSeries()
    }
}

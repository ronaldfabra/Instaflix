//
//  GetSimilarByIdUseCase.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Combine
import Foundation

protocol GetSimilarSeriesByIdUseCaseProtocol {
    func execute(id: Int, page: Int) async throws -> BaseDomailModel<SerieDomainModel>
}

class GetSimilarSeriesByIdUseCase: GetSimilarSeriesByIdUseCaseProtocol {
    let repository: SimilarRepositoryProtocol

    init(repository: SimilarRepositoryProtocol) {
        self.repository = repository
    }

    func execute(id: Int, page: Int) async throws -> BaseDomailModel<SerieDomainModel> {
        try await repository.getSimilarSeriesById(id: id, page: page)
    }
}

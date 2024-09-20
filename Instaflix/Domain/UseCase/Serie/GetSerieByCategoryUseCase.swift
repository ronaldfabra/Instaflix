//
//  GetSerieByCategoryUseCase.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Combine
import Foundation

protocol GetSerieByCategoryUseCaseProtocol {
    func execute(category: String, page: Int) async throws -> BaseDomailModel<SerieDomainModel>
}

class GetSerieByCategoryUseCase: GetSerieByCategoryUseCaseProtocol {
    let repository: SerieRepositoryProtocol

    init(repository: SerieRepositoryProtocol) {
        self.repository = repository
    }

    func execute(category: String, page: Int) async throws -> BaseDomailModel<SerieDomainModel> {
        try await repository.getSeries(category: category, page: page)
    }
}

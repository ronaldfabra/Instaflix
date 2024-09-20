//
//  GetSimilarMoviesByIdUseCase.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Combine
import Foundation

protocol GetSimilarMoviesByIdUseCaseProtocol {
    func execute(id: Int, page: Int) async throws -> BaseDomailModel<MovieDomainModel>
}

class GetSimilarMoviesByIdUseCase: GetSimilarMoviesByIdUseCaseProtocol {
    let repository: SimilarRepositoryProtocol

    init(repository: SimilarRepositoryProtocol) {
        self.repository = repository
    }

    func execute(id: Int, page: Int) async throws -> BaseDomailModel<MovieDomainModel> {
        try await repository.getSimilarMoviesById(id: id, page: page)
    }
}

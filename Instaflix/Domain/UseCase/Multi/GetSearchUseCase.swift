//
//  GetSearchMovieUseCase.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Combine
import Foundation

protocol GetSearchUseCaseProtocol {
    func execute(query: String, page: Int) async throws -> BaseDomailModel<MultiDomainModel>
}

class GetSearchUseCase: GetSearchUseCaseProtocol {
    let repository: MultiRepositoryProtocol

    init(repository: MultiRepositoryProtocol) {
        self.repository = repository
    }

    func execute(query: String, page: Int) async throws -> BaseDomailModel<MultiDomainModel> {
        try await repository.getSearch(query: query, page: page)
    }
}

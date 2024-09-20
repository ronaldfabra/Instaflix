//
//  GetMovieByCategoryUseCase.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Combine
import Foundation

protocol GetMovieByCategoryUseCaseProtocol {
    func execute(category: String, page: Int) async throws -> BaseDomailModel<MovieDomainModel>
}

class GetMovieByCategoryUseCase: GetMovieByCategoryUseCaseProtocol {
    let repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(category: String, page: Int) async throws -> BaseDomailModel<MovieDomainModel> {
        try await repository.getMovies(category: category, page: page)
    }
}

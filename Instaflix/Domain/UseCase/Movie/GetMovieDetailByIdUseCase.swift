//
//  GetMovieDetailByIdUseCase.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Combine
import Foundation

protocol GetMovieDetailByIdUseCaseProtocol {
    func execute(id: Int) async throws -> MovieDetailDomainModel
}

class GetMovieDetailByIdUseCase: GetMovieDetailByIdUseCaseProtocol {
    let repository: MovieRepositoryProtocol

    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    func execute(id: Int) async throws -> MovieDetailDomainModel {
        try await repository.getMovieDetailById(id: id)
    }
}

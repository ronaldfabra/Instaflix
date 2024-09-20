//
//  GetMyListMovieUseCase.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Foundation

protocol GetMyListMovieUseCaseProtocol {
    func execute() -> [MovieDomainModel]
}

class GetMyListMovieUseCase: GetMyListMovieUseCaseProtocol {
    let repository: MovieRepositoryProtocol

    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    func execute() -> [MovieDomainModel] {
        repository.getAllFavoritesMovies()
    }
}

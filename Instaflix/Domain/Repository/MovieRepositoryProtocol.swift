//
//  MovieRepositoryProtocol.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Combine
import Foundation

protocol MovieRepositoryProtocol {
    func getMovieDetailById(id: Int) async throws -> MovieDetailDomainModel
    func getMovies(category: String, page: Int) async throws -> BaseDomailModel<MovieDomainModel>
    func getAllFavoritesMovies() -> [MovieDomainModel]
}

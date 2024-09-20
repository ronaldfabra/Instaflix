//
//  MovieRepository.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Combine
import Foundation
import SwiftData

final class MovieRepository: MovieRepositoryProtocol {

    private let network: NetworkProtocol
    private let database:InstaflixModelContainerProtocol

    init(network: NetworkProtocol, database: InstaflixModelContainerProtocol) {
        self.network = network
        self.database = database
    }

    @MainActor
    func getMovies(category: String, page: Int) async throws -> BaseDomailModel<MovieDomainModel> {
        let response = try await network.request(endPoint: MovieEndpoint.movieByCategory(category, page),
                                                 type: BaseDto<MovieDto>.self)
        return saveMovies(response: response)
    }

    @MainActor
    func getMovieDetailById(id: Int) async throws -> MovieDetailDomainModel {
        let movie = try await network.request(endPoint: MovieEndpoint.movieDetailById(id),
                                              type: MovieDetailDto.self)
        return saveMovie(response: movie)
    }

    func getAllFavoritesMovies() -> [MovieDomainModel] {
        let movies = database.getAllFavoritesMovies()
        return movies.map { $0.toDomain() }
    }

    @MainActor
    internal func saveMovies(response: BaseDto<MovieDto>) -> BaseDomailModel<MovieDomainModel> {
        let results = database.saveMovies(response: response)
        if results.isEmpty || results.contains(where: { $0 == nil }) {
            return BaseDomailModel(page: response.page,
                                   results: response.results.map { $0.toDomain() }, 
                                   totalPages: response.totalPages,
                                   totalResults: response.totalResults)
        } else {
            return BaseDomailModel(page: response.page,
                                   results: results.compactMap { $0 }.map { $0.toDomain() },
                                   totalPages: response.totalPages,
                                   totalResults: response.totalResults)
        }
    }

    @MainActor
    internal func saveMovie(response: MovieDetailDto) -> MovieDetailDomainModel {
        var model = response.toDomain()
        guard let localModel = database.saveMovie(response: response) else {
            return model
        }
        model.isFavorite = localModel.isFavorite
        return model
    }

    @MainActor
    internal func getMovie(id: Int) -> MovieDomainModel? {
        let movie = database.getMovieById(id)
        return movie?.toDomain()
    }
}

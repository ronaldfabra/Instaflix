//
//  SimilarRepository.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation
import Combine

final class SimilarRepository: SimilarRepositoryProtocol {

    private let network: NetworkProtocol
    private let database:InstaflixModelContainerProtocol

    init(network: NetworkProtocol, database: InstaflixModelContainerProtocol) {
        self.network = network
        self.database = database
    }

    func getSimilarSeriesById(id: Int, page: Int) async throws -> BaseDomailModel<SerieDomainModel> {
        let response = try await network.request(endPoint: SerieEndpoint.serieSimilarById(id, page),
                                                 type: BaseDto<SerieDto>.self)
        return await saveSeries(response: response)
    }

    func getSimilarMoviesById(id: Int, page: Int) async throws -> BaseDomailModel<MovieDomainModel> {
        let response = try await network.request(endPoint: MovieEndpoint.movieSimilarById(id, page),
                                                 type: BaseDto<MovieDto>.self)
        return await saveMovies(response: response)
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
    internal func saveSeries(response: BaseDto<SerieDto>) -> BaseDomailModel<SerieDomainModel> {
        let results = database.saveSeries(response: response)
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
}

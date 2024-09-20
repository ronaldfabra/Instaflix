//
//  MultiRepository.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Foundation
import Combine

final class MultiRepository: MultiRepositoryProtocol {
    private let network: NetworkProtocol
    private let database:InstaflixModelContainerProtocol

    init(network: NetworkProtocol, database: InstaflixModelContainerProtocol) {
        self.network = network
        self.database = database
    }

    func getSearch(query: String, page: Int) async throws -> BaseDomailModel<MultiDomainModel> {
        let response = try await network.request(endPoint: MultiEndpoint.itemsByQuery(query, page),
                                                        type: BaseDto<MultiDto>.self)
        return await saveResults(response: response)
    }

    func setFavorite(itemId: Int, isFavorite: Bool, mediaType: MediaType) {
        database.setFavorite(itemId: itemId, isFavorite: isFavorite, mediaType: mediaType)
    }

    @MainActor
    internal func saveResults(response: BaseDto<MultiDto>) -> BaseDomailModel<MultiDomainModel> {
        let moviesAndSeries = response.results.filter { $0.mediaType == MediaType.movie.rawValue || $0.mediaType == MediaType.serie.rawValue }
        return BaseDomailModel(page: response.page,
                               results: moviesAndSeries.map { $0.toDomain() },
                               totalPages: response.totalPages,
                               totalResults: response.totalResults)
    }
}

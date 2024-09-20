//
//  SerieRepository.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation
import Combine

final class SerieRepository: SerieRepositoryProtocol {

    private let network: NetworkProtocol
    private let database:InstaflixModelContainerProtocol

    init(network: NetworkProtocol, database: InstaflixModelContainerProtocol) {
        self.network = network
        self.database = database
    }

    @MainActor
    func getSeries(category: String, page: Int) async throws -> BaseDomailModel<SerieDomainModel> {
        let response = try await network.request(endPoint: SerieEndpoint.serieByCategory(category, page),
                                                 type: BaseDto<SerieDto>.self)
        return saveSeries(response: response)
    }

    @MainActor
    func getSerieDetailById(id: Int) async throws -> SerieDetailDomainModel {
        let serie = try await network.request(endPoint: SerieEndpoint.serieDetailById(id),
                                              type: SerieDetailDto.self)
        return saveSerie(response: serie)
    }

    func getAllFavoritesSeries() -> [SerieDomainModel] {
        let movies = database.getAllFavoritesSeries()
        return movies.map { $0.toDomain() }
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

    @MainActor
    internal func saveSerie(response: SerieDetailDto) -> SerieDetailDomainModel {
        var model = response.toDomain()
        guard let localModel = database.saveSerie(response: response) else {
            return model
        }
        model.isFavorite = localModel.isFavorite
        return model
    }

    @MainActor
    internal func getSerie(id: Int) -> SerieDomainModel? {
        let serie = database.getSerieById(id)
        return serie?.toDomain()
    }
}


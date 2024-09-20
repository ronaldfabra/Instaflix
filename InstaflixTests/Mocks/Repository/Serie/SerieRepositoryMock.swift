//
//  SerieRepositoryMock.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import Foundation

class SerieRepositoryMock: SerieRepositoryProtocol {

    var mockSerieDetailByIdResponse: SerieDetailDomainModel = SerieDetailDomainModel()
    var mockSeriesResponse: BaseDomailModel<SerieDomainModel> = .init()
    var mockAllFavoritesSeriesResponse: [SerieDomainModel] = []

    func getSerieDetailById(id: Int) async throws -> Instaflix.SerieDetailDomainModel {
        if id == .zero {
            throw NetworkErrorType.invalidData
        } else {
            mockSerieDetailByIdResponse
        }
    }

    func getSeries(category: String, page: Int) async throws -> Instaflix.BaseDomailModel<Instaflix.SerieDomainModel> {
        if category.isEmpty || page == .zero {
            throw NetworkErrorType.invalidData
        } else {
            mockSeriesResponse
        }
    }

    func getAllFavoritesSeries() -> [Instaflix.SerieDomainModel] {
        mockAllFavoritesSeriesResponse
    }
}

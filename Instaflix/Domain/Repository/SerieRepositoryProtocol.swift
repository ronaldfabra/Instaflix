//
//  SerieRepositoryProtocol.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Combine
import Foundation

protocol SerieRepositoryProtocol {
    func getSerieDetailById(id: Int) async throws -> SerieDetailDomainModel
    func getSeries(category: String, page: Int) async throws -> BaseDomailModel<SerieDomainModel>
    func getAllFavoritesSeries() -> [SerieDomainModel]
}

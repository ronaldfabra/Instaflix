//
//  MultiRepositoryProtocol.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Combine
import Foundation

protocol MultiRepositoryProtocol {
    func getSearch(query: String, page: Int) async throws -> BaseDomailModel<MultiDomainModel>
    func setFavorite(itemId: Int, isFavorite: Bool, mediaType: MediaType)
}

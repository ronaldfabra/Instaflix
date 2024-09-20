//
//  MultiRepositoryMock.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import Foundation

class MultiRepositoryMock: MultiRepositoryProtocol {
    var mockSearchResponse: BaseDomailModel<MultiDomainModel> = .init()
    private(set) var itemIsFavorite: Bool = false

    func getSearch(query: String, page: Int) async throws -> Instaflix.BaseDomailModel<Instaflix.MultiDomainModel> {
        if page == .zero || query.isEmpty {
            throw NetworkErrorType.invalidData
        } else {
            mockSearchResponse
        }
    }

    func setFavorite(itemId: Int, isFavorite: Bool, mediaType: Instaflix.MediaType) {
        if itemId != .zero {
            itemIsFavorite = isFavorite
        }
    }
}

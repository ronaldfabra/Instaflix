//
//  SimilarRepositoryMock.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import Foundation

class SimilarRepositoryMock: SimilarRepositoryProtocol {

    var mockSimilarSeriesResponse: BaseDomailModel<SerieDomainModel> = .init()
    var mockSimilarMoviesResponse: BaseDomailModel<MovieDomainModel> = .init()

    func getSimilarSeriesById(id: Int, page: Int) async throws -> Instaflix.BaseDomailModel<Instaflix.SerieDomainModel> {
        if id == .zero || page == .zero {
            throw NetworkErrorType.invalidData
        } else {
            mockSimilarSeriesResponse
        }
    }

    func getSimilarMoviesById(id: Int, page: Int) async throws -> Instaflix.BaseDomailModel<Instaflix.MovieDomainModel> {
        if id == .zero || page == .zero {
            throw NetworkErrorType.invalidData
        } else {
            mockSimilarMoviesResponse
        }
    }
}

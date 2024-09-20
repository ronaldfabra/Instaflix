//
//  MovieRepositoryMock.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import Foundation

class MovieRepositoryMock: MovieRepositoryProtocol {

    var mockMovieDetailByIdResponse: MovieDetailDomainModel = MovieDetailDto.mockData().toDomain()
    var mockMoviesResponse: BaseDomailModel<MovieDomainModel> = .init()
    var mockAllFavoritesMoviesResponse: [MovieDomainModel] = []

    func getMovieDetailById(id: Int) async throws -> Instaflix.MovieDetailDomainModel {
        if id == .zero {
            throw NetworkErrorType.invalidData
        } else {
            mockMovieDetailByIdResponse
        }
    }

    func getMovies(category: String, page: Int) async throws -> Instaflix.BaseDomailModel<Instaflix.MovieDomainModel> {
        if category.isEmpty || page == .zero {
            throw NetworkErrorType.invalidData
        } else {
            mockMoviesResponse
        }
    }

    func getAllFavoritesMovies() -> [Instaflix.MovieDomainModel] {
        mockAllFavoritesMoviesResponse
    }
}


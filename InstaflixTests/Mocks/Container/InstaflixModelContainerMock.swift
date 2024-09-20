//
//  InstaflixModelContainerMock.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix

class InstaflixModelContainerMock: InstaflixModelContainerProtocol {
    var mockSaveMovies: [MovieEntity?]?
    var mockSaveMovie: MovieEntity? = nil
    var mockGetMovieById: MovieEntity? = nil
    var mockSaveSeries: [SerieEntity?]?
    var mockSaveSerie: SerieEntity? = nil
    var mockGetSerieById: SerieEntity? = nil
    var mockGetAllFavoritesMovies: [MovieEntity]?
    var mockGetAllFavoritesSeries: [SerieEntity]?
    private(set) var itemIsFavorite: Bool = false

    func saveMovies(response: Instaflix.BaseDto<Instaflix.MovieDto>) -> [Instaflix.MovieEntity?] {
        if let mockSaveMovies {
            return mockSaveMovies
        }
        return []
    }

    func saveMovie(response: Instaflix.MovieDto) -> Instaflix.MovieEntity? {
        mockSaveMovie
        
    }

    func saveMovie(response: Instaflix.MovieDetailDto) -> Instaflix.MovieEntity? {
        mockSaveMovie
    }

    func getMovieById(_ id: Int) -> Instaflix.MovieEntity? {
        mockGetMovieById
    }

    func saveSeries(response: Instaflix.BaseDto<Instaflix.SerieDto>) -> [Instaflix.SerieEntity?] {
        if let mockSaveSeries {
            return mockSaveSeries
        }
        return []
    }

    func saveSerie(response: Instaflix.SerieDto) -> Instaflix.SerieEntity? {
        mockSaveSerie
    }

    func saveSerie(response: Instaflix.SerieDetailDto) -> Instaflix.SerieEntity? {
        mockSaveSerie
    }

    func getSerieById(_ id: Int) -> Instaflix.SerieEntity? {
        mockGetSerieById
    }

    func getAllFavoritesMovies() -> [Instaflix.MovieEntity] {
        if let mockGetAllFavoritesMovies {
            return mockGetAllFavoritesMovies
        }
        return []
    }

    func getAllFavoritesSeries() -> [Instaflix.SerieEntity] {
        if let mockGetAllFavoritesSeries {
            return mockGetAllFavoritesSeries
        }
        return []
    }

    func setFavorite(itemId: Int, isFavorite: Bool, mediaType: Instaflix.MediaType) {
        if itemId != .zero {
            itemIsFavorite = isFavorite
        }
    }
}

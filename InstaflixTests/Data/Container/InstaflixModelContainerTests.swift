//
//  InstaflixModelContainerTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import SwiftData
import XCTest

final class InstaflixModelContainerTests: XCTestCase {

    var modelContainer: InstaflixModelContainer?

    @MainActor
    let testContainer: ModelContainer = {
        let schema = Schema([MovieEntity.self, SerieEntity.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Failed to create container")
        }
    }()

    override func tearDownWithError() throws {
        modelContainer = nil
    }

    func testSaveMovies() async {
        modelContainer = InstaflixModelContainer()
        modelContainer?.sharedModelContainer = testContainer
        let moviesToSave = BaseDto<MovieDto>(page: 0, results: [MovieDto.mockData()], totalPages: 0, totalResults: 1)
        let moviesSaved = await modelContainer?.saveMovies(response: moviesToSave)
        for movieSave in moviesSaved ?? [] {
            let databaseMovie = await modelContainer?.getMovieById(movieSave?.id ?? .zero)
            XCTAssertNotNil(databaseMovie)
        }
    }

    func testSaveSeries() async {
        modelContainer = InstaflixModelContainer()
        modelContainer?.sharedModelContainer = testContainer
        let seriesToSave = BaseDto<SerieDto>(page: 0, results: [SerieDto.mockData()], totalPages: 0, totalResults: 1)
        let seriesSaved = await modelContainer?.saveSeries(response: seriesToSave)
        for serieSaved in seriesSaved ?? [] {
            let databaseSerie = await modelContainer?.getSerieById(serieSaved?.id ?? .zero)
            XCTAssertNotNil(databaseSerie)
        }
    }

    func testSaveMovie() async {
        modelContainer = InstaflixModelContainer()
        modelContainer?.sharedModelContainer = testContainer
        let movieToSave = MovieDetailDto.mockData()
        _ = await modelContainer?.saveMovie(response: movieToSave)
        let movieSaved = await modelContainer?.getMovieById(movieToSave.id)
        XCTAssertNotNil(movieSaved)
    }

    func testSaveSerie() async {
        modelContainer = InstaflixModelContainer()
        modelContainer?.sharedModelContainer = testContainer
        let serieToSave = SerieDetailDto.mockData()
        _ = await modelContainer?.saveSerie(response: serieToSave)
        let serieSaved = await modelContainer?.getSerieById(serieToSave.id)
        XCTAssertNotNil(serieSaved)
    }

    func testSetMovieFavorite() async {
        modelContainer = InstaflixModelContainer()
        modelContainer?.sharedModelContainer = testContainer
        let movieToSave = MovieDetailDto.mockData()
        _ = await modelContainer?.saveMovie(response: movieToSave)
        await modelContainer?.setFavorite(itemId: movieToSave.id, isFavorite: true, mediaType: .movie)
        let movieSaved = await modelContainer?.getMovieById(movieToSave.id)
        XCTAssertNotNil(movieSaved)
        XCTAssertTrue(movieSaved?.isFavorite ?? false)
    }

    func testSetSerieFavorite() async {
        modelContainer = InstaflixModelContainer()
        modelContainer?.sharedModelContainer = testContainer
        let serieToSave = SerieDetailDto.mockData()
        _ = await modelContainer?.saveSerie(response: serieToSave)
        await modelContainer?.setFavorite(itemId: serieToSave.id, isFavorite: true, mediaType: .serie)
        let serieSaved = await modelContainer?.getSerieById(serieToSave.id)
        XCTAssertNotNil(serieSaved)
        XCTAssertTrue(serieSaved?.isFavorite ?? false)
    }

    func testGetAllFavoritesMovies() async {
        modelContainer = InstaflixModelContainer()
        modelContainer?.sharedModelContainer = testContainer
        let movieToSave = MovieDetailDto.mockData()
        _ = await modelContainer?.saveMovie(response: movieToSave)
        await modelContainer?.setFavorite(itemId: movieToSave.id, isFavorite: true, mediaType: .movie)
        let favoriteMovies = await modelContainer?.getAllFavoritesMovies()
        XCTAssertNotNil(favoriteMovies)
        for favoriteMovie in favoriteMovies ?? [] {
            XCTAssertTrue(favoriteMovie.isFavorite)
        }
    }

    func testGetAllFavoritesSeries() async {
        modelContainer = InstaflixModelContainer()
        modelContainer?.sharedModelContainer = testContainer
        let serieToSave = SerieDetailDto.mockData()
        _ = await modelContainer?.saveSerie(response: serieToSave)
        await modelContainer?.setFavorite(itemId: serieToSave.id, isFavorite: true, mediaType: .serie)
        let favoriteSeries = await modelContainer?.getAllFavoritesSeries()
        XCTAssertNotNil(favoriteSeries)
        for favoriteSerie in favoriteSeries ?? [] {
            XCTAssertTrue(favoriteSerie.isFavorite)
        }
    }
}

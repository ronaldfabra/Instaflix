//
//  InstaflixModelContainer.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Combine
import Foundation
import SwiftData


protocol InstaflixModelContainerProtocol {
    // MARK: movies
    func saveMovies(response: BaseDto<MovieDto>) -> [MovieEntity?]
    func saveMovie(response: MovieDto) -> MovieEntity?
    func saveMovie(response: MovieDetailDto) -> MovieEntity?
    func getMovieById(_ id: Int) -> MovieEntity?

    // MARK: series
    func saveSeries(response: BaseDto<SerieDto>) -> [SerieEntity?]
    func saveSerie(response: SerieDto) -> SerieEntity?
    func saveSerie(response: SerieDetailDto) -> SerieEntity?
    func getSerieById(_ id: Int) -> SerieEntity?

    // MARK: favorites
    func getAllFavoritesMovies() -> [MovieEntity]
    func getAllFavoritesSeries() -> [SerieEntity]
    func setFavorite(itemId: Int, isFavorite: Bool, mediaType: MediaType)
}

class InstaflixModelContainer: NSObject {

    static let shared: InstaflixModelContainer = InstaflixModelContainer()

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([MovieEntity.self, SerieEntity.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("unable to create the contaienr: \(error)")
        }
    }()
}

// MARK: InstaflixModelContainerProtocol
extension InstaflixModelContainer: InstaflixModelContainerProtocol {
    @MainActor
    func saveMovies(response: BaseDto<MovieDto>) -> [MovieEntity?] {
        var moviesSaved: [MovieEntity?] = []
        for result in response.results {
            moviesSaved.append(saveMovie(response: result))
        }
        return moviesSaved
    }

    @MainActor
    func saveSeries(response: BaseDto<SerieDto>) -> [SerieEntity?] {
        var seriesSaved: [SerieEntity?] = []
        for result in response.results {
            seriesSaved.append(saveSerie(response: result))
        }
        return seriesSaved
    }
}


// MARK: Save movie object
@MainActor
extension InstaflixModelContainer {
    func saveMovie(response: MovieDto) -> MovieEntity? {
        do {
            let model = response.toEntity()
            if let localMovie = getMovieById(response.id) {
                model.isFavorite = localMovie.isFavorite
            }
            sharedModelContainer.mainContext.insert(model)
            try sharedModelContainer.mainContext.save()
            return getMovieById(response.id)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func saveMovie(response: MovieDetailDto) -> MovieEntity? {
        do {
            let model = response.toEntity()
            if let localMovie = getMovieById(response.id) {
                model.isFavorite = localMovie.isFavorite
            }
            sharedModelContainer.mainContext.insert(model)
            try sharedModelContainer.mainContext.save()
            return getMovieById(response.id)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

// MARK: Save serie object
@MainActor
extension InstaflixModelContainer {
    func saveSerie(response: SerieDto) -> SerieEntity? {
        do {
            let model = response.toEntity()
            if let localMovie = getSerieById(response.id) {
                model.isFavorite = localMovie.isFavorite
            }
            sharedModelContainer.mainContext.insert(model)
            try sharedModelContainer.mainContext.save()
            return getSerieById(response.id)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func saveSerie(response: SerieDetailDto) -> SerieEntity? {
        do {
            let model = response.toEntity()
            if let localMovie = getSerieById(response.id) {
                model.isFavorite = localMovie.isFavorite
            }
            sharedModelContainer.mainContext.insert(model)
            try sharedModelContainer.mainContext.save()
            return getSerieById(response.id)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

// MARK: Items by id
@MainActor
extension InstaflixModelContainer {
    func getSerieById(_ id: Int) -> SerieEntity? {
        do {
            let moviePredicate = #Predicate<SerieEntity> {
                $0.id == id
            }
            let descriptor = FetchDescriptor<SerieEntity>(predicate: moviePredicate)
            let series = try sharedModelContainer.mainContext.fetch(descriptor)
            return series.first
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func getMovieById(_ id: Int) -> MovieEntity? {
        do {
            let moviePredicate = #Predicate<MovieEntity> {
                $0.id == id
            }
            let descriptor = FetchDescriptor<MovieEntity>(predicate: moviePredicate)
            let movies = try sharedModelContainer.mainContext.fetch(descriptor)
            return movies.first
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

// MARK: Favorites
@MainActor
extension InstaflixModelContainer {
    func setFavorite(itemId: Int, isFavorite: Bool, mediaType: MediaType) {
        do {
            switch mediaType {
                case .serie:
                    let serie = getSerieById(itemId)
                    serie?.isFavorite = isFavorite
                    try sharedModelContainer.mainContext.save()
                case .movie:
                    let movie = getMovieById(itemId)
                    movie?.isFavorite = isFavorite
                    try sharedModelContainer.mainContext.save()
            }
        }   catch {
            print(error.localizedDescription)
        }
    }

    func getAllFavoritesMovies() -> [MovieEntity] {
        do {
            let moviePredicate = #Predicate<MovieEntity> {
                $0.isFavorite
            }
            let descriptor = FetchDescriptor<MovieEntity>(predicate: moviePredicate)
            let movies = try sharedModelContainer.mainContext.fetch(descriptor)
            return movies
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    func getAllFavoritesSeries() -> [SerieEntity] {
        do {
            let moviePredicate = #Predicate<SerieEntity> {
                $0.isFavorite
            }
            let descriptor = FetchDescriptor<SerieEntity>(predicate: moviePredicate)
            let series = try sharedModelContainer.mainContext.fetch(descriptor)
            return series
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}

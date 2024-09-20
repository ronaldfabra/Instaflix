//
//  MovieDetailDto.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

struct MovieDetailDto: DTOProtocol {
    let id: Int
    let adult: Bool
    let backdropPath: String?
    let belongsToCollection: BelongsToCollectionDto?
    let budget: Int?
    let genres: [GenreDto]?
    let homepage: String?
    let imdbId: String?
    let originalLanguage: String?
    let originalTitle: String
    let overview: String
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompanyDto]?
    let productionCountries: [ProductionCountryDto]?
    let releaseDate: String
    let revenue: Int?
    let runtime: Int
    let spokenLanguages: [SpokenLanguageDto]?
    let status: String?
    let tagline: String?
    let title: String
    let voteAverage: Double?
    let voteCount: Int?

    private enum CodingKeys: String, CodingKey {
        case id, adult, budget, genres, homepage, overview, popularity, revenue, runtime, status, tagline, title
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case spokenLanguages = "spoken_languages"

        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    func toDomain() -> MovieDetailDomainModel {
        MovieDetailDomainMapper().mapValue(response: self)
    }

    func toEntity() -> MovieEntity {
        MovieDetailEntityMapper().mapValue(response: self)
    }

    static func mockData(runTime: Int = 90) -> Self {
        MovieDetailDto(
            id: 533535,
            adult: false,
            backdropPath: "/9l1eZiJHmhr5jIlthMdJN5WYoff.jpg",
            belongsToCollection: .init(backdropPath: .empty, id: 0, name: .empty, posterPath: .empty),
            budget: nil,
            genres: [.init(id: 0, name: .empty)],
            homepage: nil,
            imdbId: nil,
            originalLanguage: "/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
            originalTitle:  "dead pool",
            overview: "A listless Wade Wilson toils away in civilian life with his days as the morally flexible mercenary, Deadpool, behind him. But when his homeworld faces an existential threat, Wade must reluctantly suit-up again with an even more reluctant Wolverine.",
            popularity: nil,
            posterPath: nil,
            productionCompanies: [.init(id: 0, logoPath: .empty, name: .empty, originCountry: .empty)],
            productionCountries: [.init(name: .empty, iso31661: .empty)],
            releaseDate: "2024-07-24",
            revenue: nil,
            runtime: runTime,
            spokenLanguages:  [.init(name: "English", iso6391: "en", englishName: "English")],
            status: nil,
            tagline: nil,
            title: "",
            voteAverage: nil,
            voteCount: nil
        )
    }
}

//
//  SerieDetailDto.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

struct SerieDetailDto: DTOProtocol {
    let adult: Bool
    let backdropPath: String?
    let episodeRunTime: [Int]?
    let firstAirDate: String?
    let genres: [GenreDto]?
    let homepage: String
    let id: Int
    let languages: [String]?
    let lastAirDate: String?
    let name: String
    let numberOfEpisodes: Int?
    let numberOfSeasons: Int
    let originalCountry: [String]?
    let originalLanguage: String?
    let originalName: String
    let overview: String
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompanyDto]?
    let productionCountries: [ProductionCountryDto]?
    let spokenLanguages: [SpokenLanguageDto]?
    let status: String?
    let tagline: String?
    let voteAverage: Double?
    let voteCount: Int?

    private enum CodingKeys: String, CodingKey {
        case adult, genres, homepage, id, languages, name, overview, popularity, status, tagline
        case backdropPath = "backdrop_path"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case lastAirDate = "last_air_date"
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originalCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case spokenLanguages = "spoken_languages"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"

    }

    func toDomain() -> SerieDetailDomainModel {
        SerieDetailDomainMapper().mapValue(response: self)
    }

    func toEntity() -> SerieEntity {
        SerieDetailEntityMapper().mapValue(response: self)
    }

    static func mockData() -> Self {
        SerieDetailDto(
            adult: false,
            backdropPath: "/kkfqNkGQR5og5sDjJTxTVmI9PW.jpg",
            episodeRunTime: nil,
            firstAirDate: "2024-07-24",
            genres: [.init(id: 0, name: "Action"),
                     .init(id: 1, name: "Comedy")],
            homepage: .empty,
            id: 56998,
            languages: [],
            lastAirDate: nil,
            name: "High School of the Dead",
            numberOfEpisodes: 3,
            numberOfSeasons: 3,
            originalCountry: [],
            originalLanguage: nil,
            originalName: .empty,
            overview: "One morning, the high school student Takashi Komuro enjoys the silence at school when he's suddenly interrupted by strange noises and a shaky-legged person who tries to enter the school grounds. Subsequently, several teachers come to the school gate to shoo the person away. All of a sudden, a teacher is bitten by the person and within seconds the school campus becomes a place of violence, blood, death and undead zombies. Takashi, shocked by the scenery, runs for his life to save his schoolmates and childhood love, Rei Miyamoto. The struggle for survival has just begun…",
            popularity: 5.0,
            posterPath: "/zMWldNZF0wS3L5XkDVFHxYhclcL.jpg",
            productionCompanies: [.init(id: 0, logoPath: .empty, name: .empty, originCountry: .empty)],
            productionCountries: [.init(name: .empty, iso31661: .empty)],
            spokenLanguages: [.init(name: "English", iso6391: "en", englishName: "English")],
            status: nil,
            tagline: nil,
            voteAverage: nil,
            voteCount: nil
        )
    }
}

//
//  MovieDto.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

struct MovieDto: DTOProtocol {
    let backdropPath: String?
    let id: Int
    let title: String?
    let name: String?
    let originalTitle: String?
    let originalName: String?
    let overview: String?
    let posterPath: String?
    let adult: Bool
    let originalLanguage: String?
    let genreIds: [Int]?
    let popularity: Double
    let releaseDate: String?
    let firstAirDate: String?
    let voteAverage: Double?
    let voteCount: Int?

    func toEntity() -> MovieEntity {
        MovieEntityMapper().mapValue(response: self)
    }

    func toDomain() -> MovieDomainModel {
        MovieDomainMapper().mapValue(response: self)
    }

    private enum CodingKeys: String, CodingKey {
        case id, adult, overview, popularity, title, name
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case originalName = "original_name"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    static func mockData() -> Self {
        MovieDto(
            backdropPath: "/9l1eZiJHmhr5jIlthMdJN5WYoff.jpg",
            id: 533535,
            title: "dead pool",
            name: "dead pool",
            originalTitle: nil,
            originalName: nil,
            overview: "A listless Wade Wilson toils away in civilian life with his days as the morally flexible mercenary, Deadpool, behind him. But when his homeworld faces an existential threat, Wade must reluctantly suit-up again with an even more reluctant Wolverine.",
            posterPath: "/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
            adult: false,
            originalLanguage: nil,
            genreIds: nil,
            popularity: 5.0,
            releaseDate: "2024-04-04",
            firstAirDate: "2024",
            voteAverage: nil,
            voteCount: nil
        )
    }
}

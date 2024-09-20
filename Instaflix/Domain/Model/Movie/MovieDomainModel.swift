//
//  MovieDomainModel.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

struct MovieDomainModel: ItemInformationProtocol, Identifiable, Decodable {
    var adult: Bool
    var backdropPath: String?
    let genreIds: [Int]?
    var id: Int
    let originalLanguage: String?
    let originalTitle: String?
    var overview: String
    let popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    var title: String
    var name: String?
    let voteAverage: Double?
    let voteCount: Int?
    var releaseYear: String
    var mediaGenres: [String]?
    var spokenLanguages: [SpokenLanguageDomainModel]?
    var homepage: String?
    var numberOfSeasons: Int?
    var runtime: Int?
    var isFavorite: Bool

    static func mockData() -> Self {
        MovieDomainModel(
            adult: false,
            backdropPath: "/9l1eZiJHmhr5jIlthMdJN5WYoff.jpg",
            genreIds: nil,
            id: 533535,
            originalLanguage: nil,
            originalTitle: nil,
            overview: "A listless Wade Wilson toils away in civilian life with his days as the morally flexible mercenary, Deadpool, behind him. But when his homeworld faces an existential threat, Wade must reluctantly suit-up again with an even more reluctant Wolverine.",
            popularity: 5.0,
            posterPath: "/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
            releaseDate: "2024-04-04",
            title: "dead pool",
            name: "dead pool",
            voteAverage: nil,
            voteCount: nil, 
            releaseYear: "2024",
            mediaGenres: nil,
            spokenLanguages: nil,
            runtime: 100,
            isFavorite: false
        )
    }
}

//
//  MovieDetailDomainModel.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

struct MovieDetailDomainModel: ItemInformationProtocol {
    var adult: Bool
    var backdropPath: String?
    let belongsToCollection: BelongsToCollectionDomainModel?
    let budget: Int?
    let genres: [GenreDomainModel]?
    var mediaGenres: [String]?
    var homepage: String?
    var id: Int
    let imdbId: String?
    let originalLanguage: String?
    let originalTitle: String?
    var overview: String
    let popularity: Double?
    var posterPath: String?
    let productionCompanies: [ProductionCompanyDomainModel]?
    let productionCountries: [ProductionCountryDomainModel]?
    var releaseDate: String?
    let revenue: Int?
    var runtime: Int?
    var spokenLanguages: [SpokenLanguageDomainModel]?
    let status: String?
    let tagline: String?
    var title: String
    let voteAverage: Double?
    let voteCount: Int?
    var releaseYear: String
    var numberOfSeasons: Int?
    var isFavorite: Bool

    init(adult: Bool = false,
         backdropPath: String? = nil,
         belongsToCollection: BelongsToCollectionDomainModel? = nil,
         budget: Int? = nil,
         genres: [GenreDomainModel]? = nil,
         homepage: String? = nil,
         id: Int = 0,
         imdbId: String? = nil,
         originalLanguage: String? = nil,
         originalTitle: String? = nil,
         overview: String = "",
         popularity: Double? = nil,
         posterPath: String? = nil,
         productionCompanies: [ProductionCompanyDomainModel]? = nil,
         productionCountries: [ProductionCountryDomainModel]? = nil,
         releaseDate: String? = nil,
         revenue: Int? = nil,
         runtime: Int? = nil,
         spokenLanguages: [SpokenLanguageDomainModel]? = nil,
         status: String? = nil,
         tagline: String? = nil,
         title: String = "",
         voteAverage: Double? = nil,
         voteCount: Int? = nil,
         isFavorite: Bool = false) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.belongsToCollection = belongsToCollection
        self.budget = budget
        self.genres = genres
        self.mediaGenres = genres?.map { $0.name }
        self.homepage = homepage
        self.id = id
        self.imdbId = imdbId
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.runtime = runtime
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.tagline = tagline
        self.title = title
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.releaseYear = InstaflixUtils.getYear(from: releaseDate ?? .empty)
        self.isFavorite = isFavorite
    }

    static func == (lhs: MovieDetailDomainModel, rhs: MovieDetailDomainModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.backdropPath == rhs.backdropPath &&
        lhs.budget == rhs.budget &&
        lhs.originalTitle == rhs.originalTitle &&
        lhs.title == rhs.title
    }

    static func mockData(runTime: Int = 90) -> Self {
        MovieDetailDomainModel(
            adult: false,
            backdropPath: "/9l1eZiJHmhr5jIlthMdJN5WYoff.jpg",
            belongsToCollection: nil,
            budget: nil,
            genres: nil,
            homepage: nil,
            id: 533535,
            imdbId: nil,
            originalLanguage: "/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
            originalTitle:  "dead pool",
            overview: "A listless Wade Wilson toils away in civilian life with his days as the morally flexible mercenary, Deadpool, behind him. But when his homeworld faces an existential threat, Wade must reluctantly suit-up again with an even more reluctant Wolverine.",
            popularity: nil,
            posterPath: nil,
            releaseDate: "2024-07-24",
            runtime: runTime,
            spokenLanguages:  [.init(englishName: "English", iso6391: "en", name: "English")]
        )
    }
}

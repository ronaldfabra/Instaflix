//
//  SerieDetailDomainModel.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

struct SerieDetailDomainModel: ItemInformationProtocol {
    var adult: Bool
    var backdropPath: String?
    let episodeRunTime: [Int]?
    let firstAirDate: String?
    let genres: [GenreDomainModel]?
    var mediaGenres: [String]?
    var homepage: String?
    var id: Int
    let languages: [String]?
    let lastAirDate: String?
    let name: String
    var title: String
    let numberOfEpisodes: Int?
    var numberOfSeasons: Int?
    let originalCountry: [String]?
    let originalLanguage: String?
    let originalName: String
    var overview: String
    let popularity: Double?
    var posterPath: String?
    let productionCompanies: [ProductionCompanyDomainModel]?
    let productionCountries: [ProductionCountryDomainModel]?
    var spokenLanguages: [SpokenLanguageDomainModel]?
    let status: String?
    let tagline: String?
    let voteAverage: Double?
    let voteCount: Int?
    var releaseYear: String
    var releaseDate: String?
    var runtime: Int?
    var isFavorite: Bool

    init(adult: Bool = false,
         backdropPath: String? = nil,
         episodeRunTime: [Int]? = nil,
         firstAirDate: String? = nil,
         genres: [GenreDomainModel]? = nil,
         homepage: String? = nil,
         id: Int = 0,
         languages: [String]? = nil,
         lastAirDate: String? = nil,
         name: String = "",
         numberOfEpisodes: Int? = nil,
         numberOfSeasons: Int = 0,
         originalCountry: [String]? = nil,
         originalLanguage: String? = nil,
         originalName: String = "",
         overview: String = "",
         popularity: Double? = nil,
         posterPath: String? = nil,
         productionCompanies: [ProductionCompanyDomainModel]? = nil,
         productionCountries: [ProductionCountryDomainModel]? = nil,

         spokenLanguages: [SpokenLanguageDomainModel]? = nil,
         status: String? = nil,
         tagline: String? = nil,
         voteAverage: Double? = nil,
         voteCount: Int? = nil,
         runtime: Int? = nil,
         isFavorite: Bool = false) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.episodeRunTime = episodeRunTime
        self.firstAirDate = firstAirDate
        self.genres = genres
        self.mediaGenres = genres?.map { $0.name }
        self.homepage = homepage
        self.id = id
        self.languages = languages
        self.lastAirDate = lastAirDate
        self.name = name
        self.title = name
        self.numberOfEpisodes = numberOfEpisodes
        self.numberOfSeasons = numberOfSeasons
        self.originalCountry = originalCountry
        self.originalLanguage = originalLanguage
        self.originalName = originalName
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.tagline = tagline
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.releaseYear = InstaflixUtils.getYear(from: firstAirDate ?? .empty)
        self.releaseDate = firstAirDate
        self.runtime = runtime
        self.isFavorite = isFavorite
    }

    static func == (lhs: SerieDetailDomainModel, rhs: SerieDetailDomainModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.backdropPath == rhs.backdropPath &&
        lhs.firstAirDate == rhs.firstAirDate &&
        lhs.lastAirDate == rhs.lastAirDate &&
        lhs.originalName == rhs.originalName &&
        lhs.name == rhs.name
    }

    static func mockData() -> Self {
        SerieDetailDomainModel(
            adult: false,
            backdropPath: "/kkfqNkGQR5og5sDjJTxTVmI9PW.jpg",
            firstAirDate: "2024-07-24", 
            genres: [.init(id: 0, name: "Action"),
                     .init(id: 1, name: "Comedy")],
            id: 56998,
            name: "High School of the Dead", 
            numberOfSeasons: 3,
            originalLanguage: nil,
            originalName: .empty,
            overview: "One morning, the high school student Takashi Komuro enjoys the silence at school when he's suddenly interrupted by strange noises and a shaky-legged person who tries to enter the school grounds. Subsequently, several teachers come to the school gate to shoo the person away. All of a sudden, a teacher is bitten by the person and within seconds the school campus becomes a place of violence, blood, death and undead zombies. Takashi, shocked by the scenery, runs for his life to save his schoolmates and childhood love, Rei Miyamoto. The struggle for survival has just begun…",
            popularity: 5.0,
            posterPath: "/zMWldNZF0wS3L5XkDVFHxYhclcL.jpg",
            spokenLanguages: [.init(englishName: "English", iso6391: "en", name: "English")],
            voteAverage: nil,
            voteCount: nil
        )
    }
}

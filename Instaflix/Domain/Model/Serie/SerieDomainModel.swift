//
//  SerieDomainModel.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

struct SerieDomainModel: ItemInformationProtocol, Identifiable, Decodable {
    var adult: Bool
    var backdropPath: String?
    let genreIds: [Int]?
    var id: Int
    let originalLanguage: String?
    let originalName: String?
    var overview: String
    let popularity: Double?
    var posterPath: String?
    let firstAirDate: String?
    var releaseDate: String?
    var name: String?
    let voteAverage: Double?
    let voteCount: Int?
    var title: String
    var releaseYear: String
    var mediaGenres: [String]?
    var spokenLanguages: [SpokenLanguageDomainModel]?
    var homepage: String?
    var numberOfSeasons: Int?
    var runtime: Int?
    var isFavorite: Bool

    static func mockData() -> Self {
        SerieDomainModel(
            adult: false,
            backdropPath: "/kkfqNkGQR5og5sDjJTxTVmI9PW.jpg",
            genreIds: nil,
            id: 56998,
            originalLanguage: nil,
            originalName: nil,
            overview: "One morning, the high school student Takashi Komuro enjoys the silence at school when he's suddenly interrupted by strange noises and a shaky-legged person who tries to enter the school grounds. Subsequently, several teachers come to the school gate to shoo the person away. All of a sudden, a teacher is bitten by the person and within seconds the school campus becomes a place of violence, blood, death and undead zombies. Takashi, shocked by the scenery, runs for his life to save his schoolmates and childhood love, Rei Miyamoto. The struggle for survival has just begun…",
            popularity: 5.0,
            posterPath: "/zMWldNZF0wS3L5XkDVFHxYhclcL.jpg",
            firstAirDate: "2024-07-24",
            releaseDate: "2024-07-24",
            name: "High School of the Dead",
            voteAverage: nil,
            voteCount: nil,
            title: "High School of the Dead",
            releaseYear: "2010-07-05",
            mediaGenres: nil,
            spokenLanguages: nil,
            numberOfSeasons: 3,
            isFavorite: false
        )
    }
}

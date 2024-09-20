//
//  SerieDto.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

struct SerieDto: DTOProtocol {
    let backdropPath: String?
    let id: Int
    let name: String?
    let originalName: String?
    let overview: String?
    let posterPath: String?
    let adult: Bool
    let originalLanguage: String?
    let genreIds: [Int]?
    let popularity: Double
    let firstAirDate: String?
    let voteAverage: Double?
    let voteCount: Int?

    func toEntity() -> SerieEntity {
        SerieEntityMapper().mapValue(response: self)
    }

    func toDomain() -> SerieDomainModel {
        SerieDomainMapper().mapValue(response: self)
    }

    private enum CodingKeys: String, CodingKey {
        case id, adult, overview, popularity, name
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    static func mockData() -> Self {
        SerieDto(
            backdropPath: "/kkfqNkGQR5og5sDjJTxTVmI9PW.jpg",
            id: 56998,
            name: "High School of the Dead",
            originalName: nil,
            overview: "One morning, the high school student Takashi Komuro enjoys the silence at school when he's suddenly interrupted by strange noises and a shaky-legged person who tries to enter the school grounds. Subsequently, several teachers come to the school gate to shoo the person away. All of a sudden, a teacher is bitten by the person and within seconds the school campus becomes a place of violence, blood, death and undead zombies. Takashi, shocked by the scenery, runs for his life to save his schoolmates and childhood love, Rei Miyamoto. The struggle for survival has just begun…",
            posterPath: "/zMWldNZF0wS3L5XkDVFHxYhclcL.jpg",
            adult: false,
            originalLanguage: nil,
            genreIds: nil,
            popularity: 5.0,
            firstAirDate: "2024-07-24",
            voteAverage: nil,
            voteCount: nil
        )
    }
}

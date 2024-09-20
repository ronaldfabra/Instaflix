//
//  MultiDto.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Foundation

struct MultiDto: DTOProtocol {
    let id: Int
    let mediaType: String
    let posterPath: String?
    let title: String?
    let name: String?
    let releaseDate: String?
    let firstAirDate: String?
    let overview: String?
    let adult: Bool

    func toDomain() -> MultiDomainModel {
        MultiDomainMapper().mapValue(response: self)
    }

    private enum CodingKeys: String, CodingKey {
        case id, title, name, overview, adult
        case mediaType = "media_type"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
    }

    static func mockData() -> Self {
        MultiDto(
            id: .zero,
            mediaType: "movie",
            posterPath: .empty,
            title: .empty,
            name: .empty,
            releaseDate: .empty,
            firstAirDate: .empty,
            overview: .empty,
            adult: false
        )
    }
}

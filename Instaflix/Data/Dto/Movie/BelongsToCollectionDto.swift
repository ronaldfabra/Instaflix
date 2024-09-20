//
//  BelongsToCollectionDto.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

struct BelongsToCollectionDto: DTOProtocol {
    let backdropPath: String?
    let id: Int?
    let name: String?
    let posterPath: String?

    private enum CodingKeys: String, CodingKey {
        case id, name
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
    }

    func toDomain() -> BelongsToCollectionDomainModel {
        BelongsToCollectionDomainMapper().mapValue(response: self)
    }
}

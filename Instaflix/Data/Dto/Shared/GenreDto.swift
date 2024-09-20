//
//  GenreDto.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

struct GenreDto: DTOProtocol {
    let id: Int
    let name: String

    func toDomain() -> GenreDomainModel {
        GenreDomainMapper().mapValue(response: self)
    }
}

//
//  GenreDomainMapper.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

class GenreDomainMapper: Mapper<GenreDto, GenreDomainModel> {
    override func mapValue(response: GenreDto) -> GenreDomainModel {
        return GenreDomainModel(id: response.id,
                                name: response.name)
    }
}

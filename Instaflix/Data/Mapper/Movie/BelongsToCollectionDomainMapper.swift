//
//  BelongsToCollectionDomainMapper.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

class BelongsToCollectionDomainMapper: Mapper<BelongsToCollectionDto, BelongsToCollectionDomainModel> {
    override func mapValue(response: BelongsToCollectionDto) -> BelongsToCollectionDomainModel {
        return BelongsToCollectionDomainModel(
            backdropPath: response.backdropPath,
            id: response.id,
            name: response.name,
            posterPath: response.posterPath
        )
    }
}

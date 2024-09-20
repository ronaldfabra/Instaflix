//
//  SerieDetailEntityMapper.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 18/09/24.
//

import Foundation

class SerieDetailEntityMapper: Mapper<SerieDetailDto, SerieEntity> {
    override func mapValue(response: SerieDetailDto) -> SerieEntity {
        return SerieEntity(
            id: response.id,
            category: .empty,
            adult: response.adult,
            backdropPath: response.backdropPath,
            genreIds: response.genres?.map { $0.id },
            originalLanguage: response.originalLanguage,
            originalName: response.originalName,
            overview: response.overview,
            popularity: response.popularity,
            posterPath: response.posterPath,
            firstAirDate: response.firstAirDate,
            name: response.name,
            voteAverage: response.voteAverage,
            voteCount: response.voteCount,
            isFavorite: false
        )
    }
}

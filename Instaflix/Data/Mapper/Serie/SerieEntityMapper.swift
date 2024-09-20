//
//  SerieEntityMapper.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

class SerieEntityMapper: Mapper<SerieDto, SerieEntity> {
    override func mapValue(response: SerieDto) -> SerieEntity {
        return SerieEntity(
            id: response.id,
            category: .empty,
            adult: response.adult,
            backdropPath: response.backdropPath,
            genreIds:response.genreIds,
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

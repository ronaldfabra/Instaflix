//
//  SerieDomainMapper.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

class SerieDomainMapper: Mapper<SerieDto, SerieDomainModel> {
    override func mapValue(response: SerieDto) -> SerieDomainModel {
        return SerieDomainModel(
            adult: response.adult,
            backdropPath: response.backdropPath,
            genreIds: response.genreIds,
            id: response.id,
            originalLanguage: response.originalLanguage,
            originalName: response.originalName,
            overview: response.overview ?? String.empty,
            popularity: response.popularity,
            posterPath: response.posterPath,
            firstAirDate: response.firstAirDate,
            name: response.name,
            voteAverage: response.voteAverage,
            voteCount: response.voteCount,
            title: response.name ?? String.empty,
            releaseYear: InstaflixUtils.getYear(from: response.firstAirDate ?? .empty),
            isFavorite: false
        )
    }
}

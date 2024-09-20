//
//  MovieDetailEntityMapper.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 18/09/24.
//

import Foundation

class MovieDetailEntityMapper: Mapper<MovieDetailDto, MovieEntity> {
    override func mapValue(response: MovieDetailDto) -> MovieEntity {
        return MovieEntity(
            id: response.id,
            category: .empty,
            adult: response.adult,
            backdropPath: response.backdropPath,
            genreIds: response.genres?.map { $0.id },
            originalLanguage: response.originalLanguage,
            originalTitle: response.originalTitle,
            overview: response.overview,
            popularity: response.popularity,
            posterPath: response.posterPath,
            releaseDate: response.releaseDate,
            title: response.title,
            voteAverage: response.voteAverage,
            voteCount: response.voteCount,
            isFavorite: false
        )
    }
}

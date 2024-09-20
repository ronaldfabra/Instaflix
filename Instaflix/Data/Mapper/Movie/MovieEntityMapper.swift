//
//  MovieEntityMapper.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

class MovieEntityMapper: Mapper<MovieDto, MovieEntity> {
    override func mapValue(response: MovieDto) -> MovieEntity {
        return MovieEntity(
            id: response.id,
            category: .empty,
            adult: response.adult,
            backdropPath: response.backdropPath,
            genreIds:response.genreIds,
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

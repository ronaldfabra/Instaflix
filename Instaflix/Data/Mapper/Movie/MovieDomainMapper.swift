//
//  MovieDomainMapper.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

class MovieDomainMapper: Mapper<MovieDto, MovieDomainModel> {
    override func mapValue(response: MovieDto) -> MovieDomainModel {
        return MovieDomainModel(
            adult: response.adult,
            backdropPath: response.backdropPath,
            genreIds: response.genreIds,
            id: response.id,
            originalLanguage: response.originalLanguage,
            originalTitle: response.originalTitle,
            overview: response.overview ?? String.empty,
            popularity: response.popularity,
            posterPath: response.posterPath,
            releaseDate: response.releaseDate,
            title: response.title ?? String.empty,
            name: response.title,
            voteAverage: response.voteAverage,
            voteCount: response.voteCount, 
            releaseYear: InstaflixUtils.getYear(from: response.releaseDate ?? .empty),
            isFavorite: false
        )
    }
}

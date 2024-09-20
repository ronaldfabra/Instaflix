//
//  MovieDetailDomainMapper.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

class MovieDetailDomainMapper: Mapper<MovieDetailDto, MovieDetailDomainModel> {
    override func mapValue(response: MovieDetailDto) -> MovieDetailDomainModel {
        return MovieDetailDomainModel(
            adult: response.adult,
            backdropPath: response.backdropPath,
            belongsToCollection: response.belongsToCollection?.toDomain(),
            budget: response.budget,
            genres: response.genres?.map { $0.toDomain() },
            homepage: response.homepage,
            id: response.id,
            imdbId: response.imdbId,
            originalLanguage: response.originalLanguage,
            originalTitle: response.originalTitle,
            overview: response.overview,
            popularity: response.popularity,
            posterPath: response.posterPath,
            productionCompanies: response.productionCompanies?.map { $0.toDomain() },
            productionCountries: response.productionCountries?.map { $0.toDomain() },
            releaseDate: response.releaseDate,
            revenue: response.revenue,
            runtime: response.runtime,
            spokenLanguages: response.spokenLanguages?.map { $0.toDomain() },
            status: response.status,
            tagline: response.tagline,
            title: response.title,
            voteAverage: response.voteAverage,
            voteCount: response.voteCount
        )
    }
}

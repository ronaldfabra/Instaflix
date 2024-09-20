//
//  SerieDetailDomainMapper.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

class SerieDetailDomainMapper: Mapper<SerieDetailDto,SerieDetailDomainModel> {
    override func mapValue(response: SerieDetailDto) -> SerieDetailDomainModel {
        return SerieDetailDomainModel(
            adult: response.adult,
            backdropPath: response.backdropPath,
            episodeRunTime: response.episodeRunTime,
            firstAirDate: response.firstAirDate,
            genres: response.genres?.map { $0.toDomain() },
            homepage: response.homepage,
            id: response.id,
            languages: response.languages,
            lastAirDate: response.lastAirDate,
            name: response.name,
            numberOfEpisodes: response.numberOfEpisodes,
            numberOfSeasons: response.numberOfSeasons,
            originalCountry: response.originalCountry,
            originalLanguage: response.originalLanguage,
            originalName: response.originalName,
            overview: response.overview,
            popularity: response.popularity,
            posterPath: response.posterPath,
            productionCompanies: response.productionCompanies?.map { $0.toDomain() },
            productionCountries: response.productionCountries?.map { $0.toDomain() },
            spokenLanguages: response.spokenLanguages?.map { $0.toDomain() },
            status: response.status,
            tagline: response.tagline,
            voteAverage: response.voteAverage,
            voteCount: response.voteCount
        )
    }
}

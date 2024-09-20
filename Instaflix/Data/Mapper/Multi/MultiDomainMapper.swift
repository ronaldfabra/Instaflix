//
//  MultiDomainMapper.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Foundation

class MultiDomainMapper: Mapper<MultiDto, MultiDomainModel> {
    override func mapValue(response: MultiDto) -> MultiDomainModel {
        return MultiDomainModel(
            id: response.id,
            mediaType: MediaType(rawValue: response.mediaType) ?? .movie,
            posterPath: response.posterPath,
            overview: response.overview ?? String.empty, 
            title: response.title ?? response.name ?? String.empty,
            releaseYear: InstaflixUtils.getYear(from: response.releaseDate ?? response.firstAirDate ?? String.empty),
            adult: response.adult,
            isFavorite: false
        )
    }
}

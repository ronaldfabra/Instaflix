//
//  SerieEntity.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Foundation
import SwiftData

@Model
final class SerieEntity: Identifiable {
    @Attribute(.unique) var id: Int
    var category: String
    var adult: Bool
    var backdropPath: String?
    var genreIds: [Int]?
    var originalLanguage: String?
    var originalName: String?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var firstAirDate: String?
    var name: String?
    var voteAverage: Double?
    var voteCount: Int?
    var isFavorite: Bool

    init(id: Int, category: String, adult: Bool, backdropPath: String?, genreIds: [Int]?, originalLanguage: String?, originalName: String?, overview: String?, popularity: Double?, posterPath: String?, firstAirDate: String?, name: String?, voteAverage: Double?, voteCount: Int?, isFavorite: Bool) {
        self.id = id
        self.category = category
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIds = genreIds
        self.originalLanguage = originalLanguage
        self.originalName = originalName
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.firstAirDate = firstAirDate
        self.name = name
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.isFavorite = isFavorite
    }

    func toDomain() -> SerieDomainModel {
        SerieDomainModel(
            adult: adult,
            backdropPath: backdropPath,
            genreIds: genreIds,
            id: id,
            originalLanguage: originalLanguage,
            originalName: originalName,
            overview: overview ?? String.empty,
            popularity: popularity,
            posterPath: posterPath,
            firstAirDate: firstAirDate,
            name: name,
            voteAverage: voteAverage,
            voteCount: voteCount,
            title: name ?? .empty,
            releaseYear: InstaflixUtils.getYear(from: firstAirDate ?? .empty),
            isFavorite: isFavorite
        )
    }
}

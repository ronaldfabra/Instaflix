//
//  MovieEntity.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Foundation
import SwiftData

@Model
final class MovieEntity: Identifiable {
    @Attribute(.unique) var id: Int
    var category: String
    var adult: Bool
    var backdropPath: String?
    var genreIds: [Int]?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
    var voteAverage: Double?
    var voteCount: Int?
    var isFavorite: Bool

    init(id: Int, category: String, adult: Bool, backdropPath: String?, genreIds: [Int]?, originalLanguage: String?, originalTitle: String?, overview: String?, popularity: Double?, posterPath: String?, releaseDate: String?, title: String?, voteAverage: Double?, voteCount: Int?, isFavorite: Bool) {
        self.id = id
        self.category = category
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIds = genreIds
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.isFavorite = isFavorite
    }

    func toDomain() -> MovieDomainModel {
        MovieDomainModel(
            adult: adult,
            backdropPath: backdropPath,
            genreIds: genreIds,
            id: id,
            originalLanguage: originalLanguage,
            originalTitle: originalTitle,
            overview: overview ?? String.empty,
            popularity: popularity,
            posterPath: posterPath,
            releaseDate: releaseDate,
            title: title ?? String.empty,
            name: title,
            voteAverage: voteAverage,
            voteCount: voteCount, 
            releaseYear: InstaflixUtils.getYear(from: releaseDate ?? .empty),
            isFavorite: isFavorite
        )
    }
}

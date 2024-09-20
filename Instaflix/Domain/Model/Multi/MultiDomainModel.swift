//
//  MultiDomainModel.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Foundation

struct MultiDomainModel: Identifiable, Decodable, ItemInformationProtocol {
    var id: Int
    let mediaType: MediaType?
    var posterPath: String?
    var backdropPath: String?
    var name: String?
    var overview: String
    var title: String
    var releaseYear: String
    var releaseDate: String?
    var mediaGenres: [String]?
    var spokenLanguages: [SpokenLanguageDomainModel]?
    var homepage: String?
    var numberOfSeasons: Int?
    var runtime: Int?
    var adult: Bool
    var isFavorite: Bool

    static func mockData(mediaType: MediaType = .movie) -> Self {
        MultiDomainModel(
            id: .zero,
            mediaType: mediaType,
            posterPath: nil,
            backdropPath: nil,
            name: nil,
            overview: "",
            title: "",
            releaseYear: "",
            mediaGenres: nil,
            spokenLanguages: nil,
            adult: false,
            isFavorite: false
        )
    }
}

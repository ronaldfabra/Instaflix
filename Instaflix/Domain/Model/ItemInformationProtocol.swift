//
//  ItemInformationProtocol.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

protocol ItemInformationProtocol: Equatable {
    var id: Int { get set }
    var overview: String { get set }
    var title: String { get set }
    var releaseDate: String? { get set }
    var releaseYear: String { get set }
    var isFavorite: Bool { get set }
    var posterPath: String? { get set }
    var backdropPath: String? { get set }
    var mediaGenres: [String]? { get set }
    var spokenLanguages: [SpokenLanguageDomainModel]? { get set }
    var homepage: String? { get set }
    var numberOfSeasons: Int? { get set }
    var runtime: Int? { get set }
    var adult: Bool { get set }
}

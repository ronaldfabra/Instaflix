//
//  MediaType.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Foundation

enum MediaType: String, Decodable {
    case serie = "tv"
    case movie = "movie"

    var filterTitle: String {
        switch self {
            case .serie:
                return InstaflixContants.Strings.MediaType.seriesTitle
            case .movie:
                return InstaflixContants.Strings.MediaType.moviesTitle
        }
    }

    var enpointValue: String {
        switch self {
            case .serie:
                return "tv"
            case .movie:
                return "movie"
        }
    }
}

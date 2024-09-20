//
//  CategoryType.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Foundation

enum CategoryType {
    case nowPlaying
    case popular
    case topRatedCategory
    case upcoming
    case onTheAir
    case airingToday

    var categoryName: String {
        switch self {
            case .nowPlaying: "now_playing"
            case .popular: "popular"
            case .topRatedCategory: "top_rated"
            case .upcoming: "upcoming"
            case .onTheAir: "on_the_air"
            case .airingToday: "airing_today"
        }
    }

    var title: String {
        switch self {
            case .nowPlaying: InstaflixContants.Strings.CategoryType.nowPlaying
            case .popular: InstaflixContants.Strings.CategoryType.popular
            case .topRatedCategory: InstaflixContants.Strings.CategoryType.topRatedCategory
            case .upcoming: InstaflixContants.Strings.CategoryType.upcoming
            case .onTheAir: InstaflixContants.Strings.CategoryType.onTheAir
            case .airingToday: InstaflixContants.Strings.CategoryType.airingToday
        }
    }
}

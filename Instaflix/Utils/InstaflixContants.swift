//
//  InstaflixContants.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 18/09/24.
//

import Foundation

struct InstaflixContants {
    struct InstaflixURL {
        static let baseURL = "https://api.themoviedb.org"
        static let immage = "https://image.tmdb.org/t/p/%@/%@"
        static let apiVerion = "3"
        static let youtube = "https://www.youtube.com/embed/%@"
    }

    struct ImageSize {
        static let w200 = "w200"
        static let original = "original"
    }

    struct Icons {
        static let checkmark = "checkmark"
        static let plus = "plus"
        static let share = "paperplane"
        static let close = "xmark"
        static let home = "house"
        static let myList = "list.bullet"
        static let appLogo = "InstaflixIcon"
    }

    struct Headers {
        static let acceptKey = "accept"
        static let acceptValue = "application/json"
        static let authorizationKey = "Authorization"
    }

    struct Strings {
        static let home = "Home"
        static let myList = "My list"
        static let share = "Share"

        struct MediaType {
            static let seriesTitle = "Series"
            static let moviesTitle = "Movies"
        }

        struct CategoryType {
            static let nowPlaying = "Now playing"
            static let popular = "Popular"
            static let topRatedCategory = "Top rated"
            static let upcoming = "Upcoming"
            static let onTheAir = "On the air"
            static let airingToday = "Airing today"
        }

        struct NetworkError {
            static let invalidURL = "The url seems to be incorrect, try again later."
            static let serverError = "Internal server error, try again later."
            static let invalidData = "Error in the data obtained, try again later."
            static let internetConnection = "The internet connection appears to be offline."
            static let general = "System error, try again later"
        }
    }
}

enum InstaflixImageType {
    case poster
    case backdropPath
}

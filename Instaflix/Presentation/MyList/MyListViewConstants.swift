//
//  MyListViewConstants.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

import Foundation

struct MyListViewConstants {
    struct Dimens {
        static let spacing8 = 8.0
        static let spacing10 = 10.0
        static let spacing20 = 20.0
        static let generaHorizontalPadding = 15.0
        static let cellCornerRadius = 10.0
        static let cellHeight = 170.0
        static let cellWidth = 100.0
        static let spacingBetweenSections = 20.0
        static let spacingBetweenCells = 20.0
        static let logoWitth = 15.0
        static let logoHeight = 30.0
    }

    struct Strings {
        static let myList = "My List"
        static let emptyStateTitle = "You don't have favorites series and movies"
        static let emptyStateDescription = "Your favorite list is empty, add your favorites movies and series to be able to find them quicky here. Search and save your favorites items now!"
        static let addFavoriteHelper = "Browse our collection of series and movies, go to detail item and click on "
        static let button = "button."
    }

    struct Values {
        static let maximumOfssetToDisplayTheBackgroundHeader = -70.0
        static let backgroundHeaderBrightness = -0.2
    }
}

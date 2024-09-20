//
//  FilterDomainModel.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Foundation

struct FilterDomainModel: Hashable, Equatable {
    let title: String
    let isDropdown: Bool

    static var mockData: [FilterDomainModel] {
        [
            FilterDomainModel(title: "TV Shows", isDropdown: false),
            FilterDomainModel(title: "Movies", isDropdown: false),
            FilterDomainModel(title: "Categories", isDropdown: true)
        ]
    }
}

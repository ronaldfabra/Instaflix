//
//  MovieListDomainModel.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

struct MovieListDomainModel {
    let page: Int
    let results: [MovieDomainModel]
    let totalPages: Int
    let totalResults: Int
}

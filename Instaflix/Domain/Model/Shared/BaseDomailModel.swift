//
//  BaseDomailModel.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

struct BaseDomailModel<T: Decodable> {
    let page: Int
    let results: [T]
    let totalPages: Int
    let totalResults: Int

    init(page: Int = .zero, results: [T] = [], totalPages: Int = .zero, totalResults: Int = .zero) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}

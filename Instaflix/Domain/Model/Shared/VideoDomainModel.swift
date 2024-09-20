//
//  VideoDomainModel.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

struct VideoDomainModel {
    let id: Int
    let results: [VideoResultDomainModel]

    init(id: Int = 0, results: [VideoResultDomainModel] = []) {
        self.id = id
        self.results = results
    }
}

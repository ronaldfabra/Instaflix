//
//  SpokenLanguageDomainModel.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 116/09/24.
//

import Foundation

struct SpokenLanguageDomainModel: Decodable, Equatable {
    let englishName: String
    let iso6391: String
    let name: String

    init(englishName: String, iso6391: String, name: String) {
        self.englishName = englishName
        self.iso6391 = iso6391
        self.name = name
    }
}

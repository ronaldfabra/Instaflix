//
//  SpokenLanguageDto.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

struct SpokenLanguageDto: DTOProtocol {
    let name: String
    let iso6391: String
    let englishName: String

    private enum CodingKeys: String, CodingKey {
        case name
        case iso6391 = "iso_639_1"
        case englishName = "english_name"
    }

    func toDomain() -> SpokenLanguageDomainModel {
        SpokenLanguageDomainMapper().mapValue(response: self)
    }
}


//
//  ProductionCountryDto.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

struct ProductionCountryDto: DTOProtocol {
    let name: String
    let iso31661: String

    private enum CodingKeys: String, CodingKey {
        case name
        case iso31661 = "iso_3166_1"
    }

    func toDomain() -> ProductionCountryDomainModel {
        ProductionCountryDomainMapper().mapValue(response: self)
    }
}


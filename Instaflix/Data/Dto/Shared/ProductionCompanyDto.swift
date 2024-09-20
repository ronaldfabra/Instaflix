//
//  ProductionCompanyDto.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

struct ProductionCompanyDto: DTOProtocol {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String

    private enum CodingKeys: String, CodingKey {
        case id, name
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }

    func toDomain() -> ProductionCompanyDomainModel {
        ProductionCompanyDomainMapper().mapValue(response: self)
    }
}

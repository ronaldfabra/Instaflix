//
//  ProductionCompanyDomainMapper.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

class ProductionCompanyDomainMapper: Mapper<ProductionCompanyDto, ProductionCompanyDomainModel> {
    override func mapValue(response: ProductionCompanyDto) -> ProductionCompanyDomainModel {
        return ProductionCompanyDomainModel(
            id: response.id,
            logoPath: response.logoPath,
            name: response.name,
            originCountry: response.originCountry
        )
    }
}

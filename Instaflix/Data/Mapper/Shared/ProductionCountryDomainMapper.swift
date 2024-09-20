//
//  ProductionCountryDomainMapper.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

class ProductionCountryDomainMapper: Mapper<ProductionCountryDto, ProductionCountryDomainModel> {
    override func mapValue(response: ProductionCountryDto) -> ProductionCountryDomainModel {
        return ProductionCountryDomainModel(
            iso31661: response.iso31661,
            name: response.name
        )
    }
}

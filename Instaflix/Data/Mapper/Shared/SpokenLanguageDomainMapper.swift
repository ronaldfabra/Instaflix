//
//  SpokenLanguageDomainMapper.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

class SpokenLanguageDomainMapper: Mapper<SpokenLanguageDto, SpokenLanguageDomainModel> {
    override func mapValue(response: SpokenLanguageDto) -> SpokenLanguageDomainModel {
        return SpokenLanguageDomainModel(
            englishName: response.englishName,
            iso6391: response.iso6391,
            name: response.name
        )
    }
}

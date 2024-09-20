//
//  VideoResultDto.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Foundation

struct VideoResultDto: DTOProtocol {
    let name: String
    let key: String
    let type: String

    func toDomain() -> VideoResultDomainModel {
        VideoResultDomainMapper().mapValue(response: self)
    }
}

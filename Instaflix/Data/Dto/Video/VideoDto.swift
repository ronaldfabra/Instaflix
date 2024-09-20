//
//  VideoDto.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

struct VideoDto: DTOProtocol {
    let id: Int
    let results: [VideoResultDto]

    func toDomain() -> VideoDomainModel {
        VideoDomainMapper().mapValue(response: self)
    }
}

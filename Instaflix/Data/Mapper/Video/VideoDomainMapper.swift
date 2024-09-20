//
//  VideoDomainMapper.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

class VideoDomainMapper: Mapper<VideoDto, VideoDomainModel> {
    override func mapValue(response: VideoDto) -> VideoDomainModel {
        return VideoDomainModel(
            id: response.id,
            results: response.results.map { $0.toDomain() }
        )
    }
}

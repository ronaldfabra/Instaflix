//
//  VideoResultDomainMapper.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

class VideoResultDomainMapper: Mapper<VideoResultDto, VideoResultDomainModel> {
    override func mapValue(response: VideoResultDto) -> VideoResultDomainModel {
        return VideoResultDomainModel(
            name: response.name,
            key: response.key,
            type: .init(rawValue: response.type) ?? .trailer
        )
    }
}

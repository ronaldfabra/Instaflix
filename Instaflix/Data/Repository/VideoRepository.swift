//
//  VideoRepository.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Combine
import Foundation

final class VideoRepository: VideoRepositoryProtocol {
    private let network: NetworkProtocol

    init(network: NetworkProtocol) {
        self.network = network
    }

    func getVideoById(id: Int, path: String) async -> VideoDomainModel {
        guard let Video = try? await network.request(endPoint: VideoEndpoint.videoById(id, path), type: VideoDto.self) else {
            return VideoDomainModel()
        }
        return Video.toDomain()
    }
}

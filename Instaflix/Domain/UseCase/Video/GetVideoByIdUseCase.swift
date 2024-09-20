//
//  GetVideoByIdUseCase.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Combine
import Foundation

protocol GetVideoByIdUseCaseProtocol {
    func execute(id: Int, path: String) async throws -> VideoDomainModel
}

class GetVideoByIdUseCase: GetVideoByIdUseCaseProtocol {
    let repository: VideoRepositoryProtocol

    init(repository: VideoRepositoryProtocol) {
        self.repository = repository
    }

    func execute(id: Int, path: String) async throws -> VideoDomainModel {
        try await repository.getVideoById(id: id, path: path)
    }
}

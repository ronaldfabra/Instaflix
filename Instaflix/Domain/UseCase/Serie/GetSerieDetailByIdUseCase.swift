//
//  GetSerieDetailByIdUseCase.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Combine
import Foundation

protocol GetSerieDetailByIdUseCaseProtocol {
    func execute(id: Int) async throws -> SerieDetailDomainModel
}

class GetSerieDetailByIdUseCase: GetSerieDetailByIdUseCaseProtocol {
    let repository: SerieRepositoryProtocol
    
    init(repository: SerieRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(id: Int) async throws -> SerieDetailDomainModel {
        try await repository.getSerieDetailById(id: id)
    }
}

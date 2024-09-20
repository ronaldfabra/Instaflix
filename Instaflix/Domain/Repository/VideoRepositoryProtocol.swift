//
//  VideoRepositoryProtocol.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Combine
import Foundation

protocol VideoRepositoryProtocol {
    func getVideoById(id: Int, path: String) async throws -> VideoDomainModel
}

//
//  VideoRepositoryMock.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import Foundation

class VideoRepositoryMock: VideoRepositoryProtocol {

    var mockVideoByIdResponse: VideoDomainModel = .init()

    func getVideoById(id: Int, path: String) async throws -> Instaflix.VideoDomainModel {
        if id == .zero || path.isEmpty {
            throw NetworkErrorType.invalidData
        } else {
            mockVideoByIdResponse
        }
    }
}

//
//  VideoRepositoryTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class VideoRepositoryTests: XCTestCase {

    var repository: VideoRepositoryProtocol?
    let category = CategoryType.popular
    let itemId = 22343

    override func tearDownWithError() throws {
        repository = nil
    }

    func testGetVideo() async throws {
        let network = NetworkMock<VideoDto>()
        let mockResponse = VideoDto(id: .zero, results: [.init(name: .empty, key: .empty, type: .empty)])
        network.mockResponse = mockResponse
        repository = VideoRepository(network: network)
        do {
            let response = try await repository?.getVideoById(id: itemId, path: .empty)
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.results.count, 1)
            XCTAssertEqual(response?.results.first?.key, mockResponse.results.first?.key)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testGetSimilarSeriesWithInvalidId() async throws {
        let network = NetworkMock<VideoDto>()
        repository = VideoRepository(network: network)
        do {
            let response = try await repository?.getVideoById(id: itemId, path: .empty)
            XCTAssertNotNil(response)
        } catch let error as NetworkErrorType {
            XCTAssertEqual(error.errorDescription, NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }
}

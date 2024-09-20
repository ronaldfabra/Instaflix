//
//  GetVideoByIdUseCaseTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class GetVideoByIdUseCaseTests: XCTestCase {

    var usecase: GetVideoByIdUseCaseProtocol?
    let itemId = 61818

    override func tearDownWithError() throws {
        usecase = nil
    }

    func testfetchData() async throws {
        let videoRepository = VideoRepositoryMock()
        let mockResponse = VideoDomainModel(results: [.init(name: "name", key: "key", type: .trailer)])
        videoRepository.mockVideoByIdResponse = mockResponse
        usecase = GetVideoByIdUseCase(repository: videoRepository)
        do {
            let response = try await usecase?.execute(id: itemId, path: "movie")
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.results.count, 1)
            XCTAssertEqual(response?.results.first?.key, mockResponse.results.first?.key)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testfetchDataWithInvalidItemId() async throws {
        let videoRepository = VideoRepositoryMock()
        usecase = GetVideoByIdUseCase(repository: videoRepository)
        do {
            let response = try await usecase?.execute(id: 0, path: "movie")
            XCTAssertNil(response)
        } catch let error as NetworkErrorType {
            XCTAssertEqual(error.errorDescription, NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testfetchDataWithInvalidPath() async throws {
        let videoRepository = VideoRepositoryMock()
        usecase = GetVideoByIdUseCase(repository: videoRepository)
        do {
            let response = try await usecase?.execute(id: itemId, path: .empty)
            XCTAssertNil(response)
        } catch let error as NetworkErrorType {
            XCTAssertEqual(error.errorDescription, NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }
}

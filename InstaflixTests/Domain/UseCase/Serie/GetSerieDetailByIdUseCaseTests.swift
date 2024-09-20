//
//  GetSerieDetailByIdUseCaseTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class GetSerieDetailByIdUseCaseTests: XCTestCase {

    var usecase: GetSerieDetailByIdUseCaseProtocol?
    let serieId = 61818

    override func tearDownWithError() throws {
        usecase = nil
    }

    func testfetchData() async throws {
        let serieRepository = SerieRepositoryMock()
        let mockResponse = SerieDetailDto.mockData().toDomain()
        serieRepository.mockSerieDetailByIdResponse = mockResponse
        usecase = GetSerieDetailByIdUseCase(repository: serieRepository)
        do {
            let response = try await usecase?.execute(id: serieId)
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.id, mockResponse.id)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testfetchDataWithInvalidSerieId() async throws {
        let serieRepository = SerieRepositoryMock()
        usecase = GetSerieDetailByIdUseCase(repository: serieRepository)
        do {
            let response = try await usecase?.execute(id: 0)
            XCTAssertNil(response)
        } catch let error as NetworkErrorType {
            XCTAssertEqual(error.errorDescription, NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }
}

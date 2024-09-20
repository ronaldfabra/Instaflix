//
//  GetSimilarSeriesByIdUseCaseTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class GetSimilarSeriesByIdUseCaseTests: XCTestCase {

    var usecase: GetSimilarSeriesByIdUseCaseProtocol?
    let serieId = 61818

    override func tearDownWithError() throws {
        usecase = nil
    }

    func testfetchData() async throws {
        let similarRepository = SimilarRepositoryMock()
        let serieResponse = SerieDto.mockData().toDomain()
        similarRepository.mockSimilarSeriesResponse = .init(results: [serieResponse])
        usecase = GetSimilarSeriesByIdUseCase(repository: similarRepository)
        do {
            let response = try await usecase?.execute(id: serieId, page: 1)
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.results.count, 1)
            XCTAssertEqual(response?.results.first?.id, serieResponse.id)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testfetchDataWithInvalidSerieId() async throws {
        let similarRepository = SimilarRepositoryMock()
        usecase = GetSimilarSeriesByIdUseCase(repository: similarRepository)
        do {
            let response = try await usecase?.execute(id: 0, page: 1)
            XCTAssertNotNil(response)
        } catch let error as NetworkErrorType {
            XCTAssertEqual(error.errorDescription, NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testfetchDataWithInvalidPage() async throws {
        let similarRepository = SimilarRepositoryMock()
        usecase = GetSimilarSeriesByIdUseCase(repository: similarRepository)
        do {
            let response = try await usecase?.execute(id: serieId, page: 0)
            XCTAssertNotNil(response)
        } catch let error as NetworkErrorType {
            XCTAssertEqual(error.errorDescription, NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }
}

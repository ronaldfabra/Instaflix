//
//  SimilarRepositoryTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class SimilarRepositoryTests: XCTestCase {

    var repository: SimilarRepositoryProtocol?
    let category = CategoryType.popular
    let serieId = 22343

    override func tearDownWithError() throws {
        repository = nil
    }

    func testGetSimilarSeries() async throws {
        let network = NetworkMock<BaseDto<SerieDto>>()
        let database = InstaflixModelContainerMock()
        let mockResponse = BaseDto<SerieDto>(page: 0, results: [SerieDto.mockData()], totalPages: 0, totalResults: 1)
        network.mockResponse = mockResponse
        repository = SimilarRepository(network: network, database: database)
        do {
            let response = try await repository?.getSimilarSeriesById(id: serieId, page: 1)
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.results.count, 1)
            XCTAssertEqual(response?.results.first?.id, mockResponse.results.first?.id)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testGetSimilarSeriesWithInvalidId() async throws {
        let network = NetworkMock<BaseDto<SerieDto>>()
        let database = InstaflixModelContainerMock()
        repository = SimilarRepository(network: network, database: database)
        do {
            let response = try await repository?.getSimilarSeriesById(id: .zero, page: .zero)
            XCTAssertNotNil(response)
        } catch let error as NetworkErrorType {
            XCTAssertEqual(error.errorDescription, NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testGetSimilarMovies() async throws {
        let network = NetworkMock<BaseDto<MovieDto>>()
        let database = InstaflixModelContainerMock()
        let mockResponse = BaseDto<MovieDto>(page: 0, results: [MovieDto.mockData()], totalPages: 0, totalResults: 1)
        network.mockResponse = mockResponse
        repository = SimilarRepository(network: network, database: database)
        do {
            let response = try await repository?.getSimilarMoviesById(id: serieId, page: 1)
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.results.count, 1)
            XCTAssertEqual(response?.results.first?.id, mockResponse.results.first?.id)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testGetSimilarMoviesWithInvalidId() async throws {
        let network = NetworkMock<BaseDto<SerieDto>>()
        let database = InstaflixModelContainerMock()
        repository = SimilarRepository(network: network, database: database)
        do {
            let response = try await repository?.getSimilarMoviesById(id: .zero, page: .zero)
            XCTAssertNotNil(response)
        } catch let error as NetworkErrorType {
            XCTAssertEqual(error.errorDescription, NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }
}

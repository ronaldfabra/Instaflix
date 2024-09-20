//
//  SerieRepositoryTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class SerieRepositoryTests: XCTestCase {

    var repository: SerieRepositoryProtocol?
    let category = CategoryType.popular
    let serieId = 22343

    override func tearDownWithError() throws {
        repository = nil
    }

    func testGetSeries() async throws {
        let network = NetworkMock<BaseDto<SerieDto>>()
        let database = InstaflixModelContainerMock()
        let mockResponse = BaseDto<SerieDto>(page: 0, results: [SerieDto.mockData()], totalPages: 0, totalResults: 1)
        network.mockResponse = mockResponse
        repository = SerieRepository(network: network, database: database)
        do {
            let response = try await repository?.getSeries(category: category.categoryName, page: 1)
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.results.count, 1)
            XCTAssertEqual(response?.results.first?.id, mockResponse.results.first?.id)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testGetSeriesWithInvalidCategoryName() async throws {
        let network = NetworkMock<BaseDto<SerieDto>>()
        let database = InstaflixModelContainerMock()
        repository = SerieRepository(network: network, database: database)
        do {
            let response = try await repository?.getSeries(category: "", page: 1)
            XCTAssertNotNil(response)
        } catch let error as NetworkErrorType {
            XCTAssertEqual(error.errorDescription, NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testGetSeriesWithInvalidPage() async throws {
        let network = NetworkMock<BaseDto<SerieDto>>()
        let database = InstaflixModelContainerMock()
        repository = SerieRepository(network: network, database: database)
        do {
            let response = try await repository?.getSeries(category: category.categoryName, page: 0)
            XCTAssertNil(response)
        } catch let error as NetworkErrorType {
            XCTAssertEqual(error.errorDescription, NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testGetSerieDetailById() async throws {
        let network = NetworkMock<SerieDetailDto>()
        let database = InstaflixModelContainerMock()
        let mockResponse = SerieDetailDto.mockData()
        network.mockResponse = mockResponse
        repository = SerieRepository(network: network, database: database)
        do {
            let response = try await repository?.getSerieDetailById(id: serieId)
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.id, mockResponse.id)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testGetSerieDetailByIdWithInvalidSerieId() async throws {
        let network = NetworkMock<SerieDetailDto>()
        let database = InstaflixModelContainerMock()
        repository = SerieRepository(network: network, database: database)
        do {
            let response = try await repository?.getSerieDetailById(id: .zero)
            XCTAssertNotNil(response)
        } catch let error as NetworkErrorType {
            XCTAssertEqual(error.errorDescription, NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testGetAllFavoritesSeries() {
        let network = NetworkMock<[SerieDomainModel]>()
        let database = InstaflixModelContainerMock()
        let mockResponse = [SerieDetailDto.mockData().toEntity()]
        database.mockGetAllFavoritesSeries = mockResponse
        repository = SerieRepository(network: network, database: database)
        let response = repository?.getAllFavoritesSeries()
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.count, 1)
        XCTAssertEqual(response?.first?.id, mockResponse.first?.id)
    }

    func testGetAllFavoritesSeriesWithoutValues() {
        let network = NetworkMock<[SerieDomainModel]>()
        let database = InstaflixModelContainerMock()
        repository = SerieRepository(network: network, database: database)
        let response = repository?.getAllFavoritesSeries()
        XCTAssertNotNil(response)
    }
}

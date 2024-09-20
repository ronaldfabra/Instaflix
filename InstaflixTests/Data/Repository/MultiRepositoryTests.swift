//
//  MultiRepositoryTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class MultiRepositoryTests: XCTestCase {

    var repository: MultiRepositoryProtocol?
    let category = CategoryType.popular
    let itemId = 22343

    override func tearDownWithError() throws {
        repository = nil
    }

    func testGetSearch() async throws {
        let network = NetworkMock<BaseDto<MultiDto>>()
        let database = InstaflixModelContainerMock()
        let mockResponse = BaseDto<MultiDto>(page: 0, results: [MultiDto.mockData()], totalPages: 0, totalResults: 1)
        network.mockResponse = mockResponse
        repository = MultiRepository(network: network, database: database)
        do {
            let response = try await repository?.getSearch(query: "query", page: 1)
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.results.count, 1)
            XCTAssertEqual(response?.results.first?.id, mockResponse.results.first?.id)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testGetSearchWithInvalidQuery() async throws {
        let network = NetworkMock<BaseDto<MultiDto>>()
        let database = InstaflixModelContainerMock()
        repository = MultiRepository(network: network, database: database)
        do {
            let response = try await repository?.getSearch(query: .empty, page: .zero)
            XCTAssertNotNil(response)
        } catch let error as NetworkErrorType {
            XCTAssertEqual(error.errorDescription, NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testSetFavoriteTrue() {
        let network = NetworkMock<BaseDto<MultiDto>>()
        let database = InstaflixModelContainerMock()
        repository = MultiRepository(network: network, database: database)
        repository?.setFavorite(itemId: itemId, isFavorite: true, mediaType: .serie)
        XCTAssertTrue(database.itemIsFavorite)
    }

    func testSetFavoriteFalse() {
        let network = NetworkMock<BaseDto<MultiDto>>()
        let database = InstaflixModelContainerMock()
        repository = MultiRepository(network: network, database: database)
        repository?.setFavorite(itemId: itemId, isFavorite: false, mediaType: .serie)
        XCTAssertFalse(database.itemIsFavorite)
    }
}

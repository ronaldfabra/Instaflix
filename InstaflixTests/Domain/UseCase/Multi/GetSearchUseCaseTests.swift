//
//  GetSearchUseCaseTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class GetSearchUseCaseTests: XCTestCase {

    var usecase: GetSearchUseCaseProtocol?
    let itemId = 61818

    override func tearDownWithError() throws {
        usecase = nil
    }

    func testfetchData() async throws {
        let multiRepository = MultiRepositoryMock()
        let multiResponse = MultiDomainModel.mockData()
        multiRepository.mockSearchResponse = .init(results: [multiResponse])
        usecase = GetSearchUseCase(repository: multiRepository)
        do {
            let response = try await usecase?.execute(query: "query", page: 1)
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.results.count, 1)
            XCTAssertEqual(response?.results.first?.id, multiResponse.id)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testfetchDataWithInvalidQuery() async throws {
        let multiRepository = MultiRepositoryMock()
        usecase = GetSearchUseCase(repository: multiRepository)
        do {
            let response = try await usecase?.execute(query: .empty, page: 1)
            XCTAssertNil(response)
        } catch let error as NetworkErrorType {
            XCTAssertEqual(error.errorDescription, NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testfetchDataWithInvalidPage() async throws {
        let multiRepository = MultiRepositoryMock()
        usecase = GetSearchUseCase(repository: multiRepository)
        do {
            let response = try await usecase?.execute(query: "query", page: 0)
            XCTAssertNil(response)
        } catch let error as NetworkErrorType {
            XCTAssertEqual(error.errorDescription, NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }
}

//
//  GetSerieByCategoryUseCaseTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class GetSerieByCategoryUseCaseTests: XCTestCase {

    var usecase: GetSerieByCategoryUseCaseProtocol?
    let category = CategoryType.popular

    override func tearDownWithError() throws {
        usecase = nil
    }

    func testfetchData() async throws {
        let serieRepository = SerieRepositoryMock()
        let serieResponse = SerieDto.mockData().toDomain()
        serieRepository.mockSeriesResponse = .init(results: [serieResponse])
        usecase = GetSerieByCategoryUseCase(repository: serieRepository)
        do {
            let response = try await usecase?.execute(category: category.categoryName, page: 1)
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.results.count, 1)
            XCTAssertEqual(response?.results.first?.id, serieResponse.id)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testfetchDataWithInvalidCategoryName() async throws {
        let serieRepository = SerieRepositoryMock()
        usecase = GetSerieByCategoryUseCase(repository: serieRepository)
        do {
            let response = try await usecase?.execute(category: "", page: 1)
            XCTAssertNotNil(response)
        } catch let error as NetworkErrorType {
            XCTAssertEqual(error.errorDescription, NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testfetchDataWithInvalidPage() async throws {
        let serieRepository = SerieRepositoryMock()
        usecase = GetSerieByCategoryUseCase(repository: serieRepository)
        do {
            let response = try await usecase?.execute(category: category.categoryName, page: 0)
            XCTAssertNil(response)
        } catch let error as NetworkErrorType {
            XCTAssertEqual(error.errorDescription, NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }
}

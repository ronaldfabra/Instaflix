//
//  GetMovieByCategoryUseCaseTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class GetMovieByCategoryUseCaseTests: XCTestCase {

    var usecase: GetMovieByCategoryUseCaseProtocol?
    let category = CategoryType.popular

    override func tearDownWithError() throws {
        usecase = nil
    }

    func testfetchData() async throws {
        let movieRepository = MovieRepositoryMock()
        let movieResponse = MovieDto.mockData().toDomain()
        movieRepository.mockMoviesResponse = .init(results: [movieResponse])
        usecase = GetMovieByCategoryUseCase(repository: movieRepository)
        do {
            let response = try await usecase?.execute(category: category.categoryName, page: 1)
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.results.count, 1)
            XCTAssertEqual(response?.results.first?.id, movieResponse.id)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testfetchDataWithInvalidCategoryName() async throws {
        let movieRepository = MovieRepositoryMock()
        usecase = GetMovieByCategoryUseCase(repository: movieRepository)
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
        let movieRepository = MovieRepositoryMock()
        usecase = GetMovieByCategoryUseCase(repository: movieRepository)
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

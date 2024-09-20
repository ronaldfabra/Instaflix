//
//  GetMovieDetailByIdUseCaseTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class GetMovieDetailByIdUseCaseTests: XCTestCase {

    var usecase: GetMovieDetailByIdUseCaseProtocol?
    let movieId = 61818

    override func tearDownWithError() throws {
        usecase = nil
    }

    func testfetchData() async throws {
        let movieRepository = MovieRepositoryMock()
        let mockResponse = MovieDetailDto.mockData().toDomain()
        movieRepository.mockMovieDetailByIdResponse = mockResponse
        usecase = GetMovieDetailByIdUseCase(repository: movieRepository)
        do {
            let response = try await usecase?.execute(id: movieId)
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.id, mockResponse.id)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testfetchDataWithInvalidMovieId() async throws {
        let movieRepository = MovieRepositoryMock()
        usecase = GetMovieDetailByIdUseCase(repository: movieRepository)
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

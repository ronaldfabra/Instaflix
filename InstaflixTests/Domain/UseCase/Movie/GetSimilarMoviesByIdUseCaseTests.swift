//
//  GetSimilarMoviesByIdUseCaseTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class GetSimilarMoviesByIdUseCaseTests: XCTestCase {

    var usecase: GetSimilarMoviesByIdUseCaseProtocol?
    let movieId = 61818

    override func tearDownWithError() throws {
        usecase = nil
    }

    func testfetchData() async throws {
        let similarRepository = SimilarRepositoryMock()
        let movieResponse = MovieDto.mockData().toDomain()
        similarRepository.mockSimilarMoviesResponse = .init(results: [movieResponse])
        usecase = GetSimilarMoviesByIdUseCase(repository: similarRepository)
        do {
            let response = try await usecase?.execute(id: movieId, page: 1)
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.results.count, 1)
            XCTAssertEqual(response?.results.first?.id, movieResponse.id)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testfetchDataWithInvalidmovieId() async throws {
        let similarRepository = SimilarRepositoryMock()
        usecase = GetSimilarMoviesByIdUseCase(repository: similarRepository)
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
        usecase = GetSimilarMoviesByIdUseCase(repository: similarRepository)
        do {
            let response = try await usecase?.execute(id: movieId, page: 0)
            XCTAssertNotNil(response)
        } catch let error as NetworkErrorType {
            XCTAssertEqual(error.errorDescription, NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }
}

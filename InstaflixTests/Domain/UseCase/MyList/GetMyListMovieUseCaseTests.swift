//
//  GetMyListMovieUseCaseTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class GetMyListMovieUseCaseTests: XCTestCase {
    var usecase: GetMyListMovieUseCaseProtocol?
    let itemId = 61818

    override func tearDownWithError() throws {
        usecase = nil
    }

    func testfetchData() {
        let movieRepository = MovieRepositoryMock()
        let movieResponse = MovieDto.mockData().toDomain()
        movieRepository.mockAllFavoritesMoviesResponse = [movieResponse]
        usecase = GetMyListMovieUseCase(repository: movieRepository)
        let response = usecase?.execute()
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.count, 1)
        XCTAssertEqual(response?.first?.id, movieResponse.id)
    }

    func testfetchDataWithoutFavorites(){
        let movieRepository = MovieRepositoryMock()
        usecase = GetMyListMovieUseCase(repository: movieRepository)
        let response = usecase?.execute()
        XCTAssertNotNil(response)
        XCTAssertTrue(response?.isEmpty ?? false)
    }
}

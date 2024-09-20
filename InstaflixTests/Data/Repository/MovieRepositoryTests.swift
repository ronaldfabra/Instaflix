//
//  MovieRepositoryTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class MovieRepositoryTests: XCTestCase {

    var repository: MovieRepositoryProtocol?
    let category = CategoryType.popular
    let movieId = 22343

    override func tearDownWithError() throws {
        repository = nil
    }

    func testGetMovies() async throws {
        let network = NetworkMock<BaseDto<MovieDto>>()
        let database = InstaflixModelContainerMock()
        let mockResponse = BaseDto<MovieDto>(page: 0, results: [MovieDto.mockData()], totalPages: 0, totalResults: 1)
        network.mockResponse = mockResponse
        repository = MovieRepository(network: network, database: database)
        do {
            let response = try await repository?.getMovies(category: category.categoryName, page: 1)
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.results.count, 1)
            XCTAssertEqual(response?.results.first?.id, mockResponse.results.first?.id)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testGetMoviesWithInvalidCategoryName() async throws {
        let network = NetworkMock<BaseDto<MovieDto>>()
        let database = InstaflixModelContainerMock()
        repository = MovieRepository(network: network, database: database)
        do {
            let response = try await repository?.getMovies(category: "", page: 1)
            XCTAssertNotNil(response)
        } catch let error as NetworkErrorType {
            XCTAssertEqual(error.errorDescription, NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testGetMoviesWithInvalidPage() async throws {
        let network = NetworkMock<BaseDto<MovieDto>>()
        let database = InstaflixModelContainerMock()
        repository = MovieRepository(network: network, database: database)
        do {
            let response = try await repository?.getMovies(category: category.categoryName, page: 0)
            XCTAssertNil(response)
        } catch let error as NetworkErrorType {
            XCTAssertEqual(error.errorDescription, NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testGetMovieDetailById() async throws {
        let network = NetworkMock<MovieDetailDto>()
        let database = InstaflixModelContainerMock()
        let mockResponse = MovieDetailDto.mockData()
        network.mockResponse = mockResponse
        repository = MovieRepository(network: network, database: database)
        do {
            let response = try await repository?.getMovieDetailById(id: movieId)
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.id, mockResponse.id)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testGetMovieDetailByIdWithInvalidMovieId() async throws {
        let network = NetworkMock<MovieDetailDto>()
        let database = InstaflixModelContainerMock()
        repository = MovieRepository(network: network, database: database)
        do {
            let response = try await repository?.getMovieDetailById(id: .zero)
            XCTAssertNotNil(response)
        } catch let error as NetworkErrorType {
            XCTAssertEqual(error.errorDescription, NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testGetAllFavoritesMovies() {
        let network = NetworkMock<[MovieDomainModel]>()
        let database = InstaflixModelContainerMock()
        let mockResponse = [MovieDto.mockData().toEntity()]
        database.mockGetAllFavoritesMovies = mockResponse
        repository = MovieRepository(network: network, database: database)
        let response = repository?.getAllFavoritesMovies()
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.count, 1)
        XCTAssertEqual(response?.first?.id, mockResponse.first?.id)
    }

    func testGetAllFavoritesMoviesWithoutValues() {
        let network = NetworkMock<[MovieDomainModel]>()
        let database = InstaflixModelContainerMock()
        repository = MovieRepository(network: network, database: database)
        let response = repository?.getAllFavoritesMovies()
        XCTAssertNotNil(response)
    }
}

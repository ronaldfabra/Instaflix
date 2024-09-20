//
//  MovieListViewModelTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class MovieListViewModelTests: XCTestCase {

    var viewModel: MovieListViewModel?

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testfetchData() async {
        let movieRepository = MovieRepositoryMock()
        let movieResponse = MovieDto.mockData().toDomain()
        movieRepository.mockMoviesResponse = .init(results: [movieResponse])
        let getMovieByCategoryUseCase = GetMovieByCategoryUseCase(repository: movieRepository)
        viewModel = MovieListViewModel(getMovieByCategoryUseCase: getMovieByCategoryUseCase)

        await viewModel?.fetchAllMovies()
        XCTAssertNotNil(viewModel?.categories)
        XCTAssertNotNil(viewModel?.categories.first)
        XCTAssertEqual(viewModel?.categories.first?.list.count, 1)
        XCTAssertEqual(viewModel?.categories.first?.list.first?.id, movieResponse.id)
    }

    func testfetchDataWithInvalidPage() async throws {
        let movieRepository = MovieRepositoryMock()
        let movieResponse = MovieDto.mockData().toDomain()
        movieRepository.mockMoviesResponse = .init(results: [movieResponse])
        let getMovieByCategoryUseCase = GetMovieByCategoryUseCase(repository: movieRepository)
        viewModel = MovieListViewModel(getMovieByCategoryUseCase: getMovieByCategoryUseCase)
        if let category = viewModel?.categories.first, ((viewModel?.categories.indices.contains(0)) != nil) {
            viewModel?.categories[0].page = -1
            await viewModel?.fetchMovies(by: category)
            XCTAssertTrue((viewModel?.categories.first?.list ?? []).isEmpty)
        }

    }

    func testOnMoviePressed()  {
        let movie = MovieDto.mockData().toDomain()
        let movieRepository = MovieRepositoryMock()
        let getMovieByCategoryUseCase = GetMovieByCategoryUseCase(repository: movieRepository)
        viewModel = MovieListViewModel(getMovieByCategoryUseCase: getMovieByCategoryUseCase)

        viewModel?.onMoviePressed(movie)
        XCTAssertNotNil(viewModel?.movieSelected)
        XCTAssertTrue(viewModel?.showMovieDetailView ?? false)
    }

    func testOnPaginateIfNeeded() async {
        let movieRepository = MovieRepositoryMock()
        let movieResponse = MovieDto.mockData().toDomain()
        movieRepository.mockMoviesResponse = .init(results: [movieResponse])
        let getMovieByCategoryUseCase = GetMovieByCategoryUseCase(repository: movieRepository)
        viewModel = MovieListViewModel(getMovieByCategoryUseCase: getMovieByCategoryUseCase)
        var category = viewModel?.categories.first ?? CategoryDomailModel<MovieDomainModel>(category: .popular, totalPages: 1, list: [])
        category.totalPages = 1
        await viewModel?.onPaginateIfNeeded(category: category)
        XCTAssertFalse((viewModel?.categories.first?.list ?? []).isEmpty)
    }
}

//
//  MyListViewModelTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class MyListViewModelTests: XCTestCase {

    var viewModel: MyListViewModel?

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testfetchAllData() {
        let movieRepository = MovieRepositoryMock()
        let movieResponse = MovieDto.mockData().toDomain()
        movieRepository.mockAllFavoritesMoviesResponse = [movieResponse]
        let serieRepository = SerieRepositoryMock()
        let serieResponse = SerieDto.mockData().toDomain()
        serieRepository.mockAllFavoritesSeriesResponse = [serieResponse]
        let getMyListMovieUseCase = GetMyListMovieUseCase(repository: movieRepository)
        let getMyListSerieUseCase = GetMyListSerieUseCase(repository: serieRepository)
        viewModel = MyListViewModel(getMyListMovieUseCase: getMyListMovieUseCase,
                                    getMyListSerieUseCase: getMyListSerieUseCase)
        viewModel?.fetchAllData()
        XCTAssertNotNil(viewModel?.movieList)
        XCTAssertFalse(viewModel?.movieList.isEmpty ?? true)
        XCTAssertEqual(viewModel?.movieList.count, 1)
        XCTAssertEqual(viewModel?.movieList.first?.id, movieResponse.id)
        XCTAssertNotNil(viewModel?.serieList)
        XCTAssertFalse(viewModel?.serieList.isEmpty ?? true)
        XCTAssertEqual(viewModel?.serieList.count, 1)
        XCTAssertEqual(viewModel?.serieList.first?.id, serieResponse.id)
    }

    func testfetchMovies() {
        let movieRepository = MovieRepositoryMock()
        let movieResponse = MovieDto.mockData().toDomain()
        movieRepository.mockAllFavoritesMoviesResponse = [movieResponse]
        let serieRepository = SerieRepositoryMock()
        let getMyListMovieUseCase = GetMyListMovieUseCase(repository: movieRepository)
        let getMyListSerieUseCase = GetMyListSerieUseCase(repository: serieRepository)
        viewModel = MyListViewModel(getMyListMovieUseCase: getMyListMovieUseCase,
                                    getMyListSerieUseCase: getMyListSerieUseCase)
        viewModel?.fetchMovies()
        XCTAssertNotNil(viewModel?.movieList)
        XCTAssertFalse(viewModel?.movieList.isEmpty ?? true)
        XCTAssertEqual(viewModel?.movieList.count, 1)
        XCTAssertEqual(viewModel?.movieList.first?.id, movieResponse.id)
    }

    func testfetchSeries() {
        let movieRepository = MovieRepositoryMock()
        let serieRepository = SerieRepositoryMock()
        let serieResponse = SerieDto.mockData().toDomain()
        serieRepository.mockAllFavoritesSeriesResponse = [serieResponse]
        let getMyListMovieUseCase = GetMyListMovieUseCase(repository: movieRepository)
        let getMyListSerieUseCase = GetMyListSerieUseCase(repository: serieRepository)
        viewModel = MyListViewModel(getMyListMovieUseCase: getMyListMovieUseCase,
                                    getMyListSerieUseCase: getMyListSerieUseCase)
        viewModel?.fetchSeries()
        XCTAssertNotNil(viewModel?.serieList)
        XCTAssertFalse(viewModel?.serieList.isEmpty ?? true)
        XCTAssertEqual(viewModel?.serieList.count, 1)
        XCTAssertEqual(viewModel?.serieList.first?.id, serieResponse.id)
    }

    func testOnMoviePressed() {
        let movieRepository = MovieRepositoryMock()
        let serieRepository = SerieRepositoryMock()
        let movie = MovieDomainModel.mockData()
        let getMyListMovieUseCase = GetMyListMovieUseCase(repository: movieRepository)
        let getMyListSerieUseCase = GetMyListSerieUseCase(repository: serieRepository)
        viewModel = MyListViewModel(getMyListMovieUseCase: getMyListMovieUseCase,
                                    getMyListSerieUseCase: getMyListSerieUseCase)
        viewModel?.onMoviePressed(movie)
        XCTAssertNotNil(viewModel?.movieSelected)
        XCTAssertTrue(viewModel?.showMovieDetailView ?? false)
    }

    func testOnSeriePressed() {
        let movieRepository = MovieRepositoryMock()
        let serieRepository = SerieRepositoryMock()
        let serie = SerieDomainModel.mockData()
        let getMyListMovieUseCase = GetMyListMovieUseCase(repository: movieRepository)
        let getMyListSerieUseCase = GetMyListSerieUseCase(repository: serieRepository)
        viewModel = MyListViewModel(getMyListMovieUseCase: getMyListMovieUseCase,
                                    getMyListSerieUseCase: getMyListSerieUseCase)
        viewModel?.onSeriePressed(serie)
        XCTAssertNotNil(viewModel?.serieSelected)
        XCTAssertTrue(viewModel?.showSerieDetailView ?? false)
    }

}

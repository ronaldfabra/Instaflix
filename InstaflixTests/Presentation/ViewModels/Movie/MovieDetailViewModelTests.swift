//
//  MovieDetailViewModelTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class MovieDetailViewModelTests: XCTestCase {

    var viewModel: MovieDetailViewModel?
    let movieId = 61818

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testfetchData() async {
        let movieRepository = MovieRepositoryMock()
        let mockResponse = MovieDetailDomainModel.mockData()
        movieRepository.mockMovieDetailByIdResponse = mockResponse
        let getMovieByIdUseCase = GetMovieDetailByIdUseCase(repository: movieRepository)
        let similarRepository = SimilarRepositoryMock()
        similarRepository.mockSimilarMoviesResponse = .init(results: [MovieDto.mockData().toDomain()])
        let getSimilarMoviesByIdUseCase = GetSimilarMoviesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepositoryMock()
        let getMovieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        viewModel = MovieDetailViewModel(
            getMovieByIdUseCase: getMovieByIdUseCase,
            getSimilarMoviesByIdUseCase: getSimilarMoviesByIdUseCase,
            getMovieVideoByIdUseCase: getMovieVideoByIdUseCase,
            movie: nil
        )

        await viewModel?.fetchAllInformation(movieId: movieId)
        XCTAssertNotNil(viewModel?.currentMovie)
        XCTAssertEqual(viewModel?.currentMovie?.id, mockResponse.id)
        XCTAssertFalse((viewModel?.similarList ?? []).isEmpty)
        XCTAssertNotNil(viewModel?.videoDomainModel)
    }

    func testfetchSimilar() async throws {
        let movieRepository = MovieRepositoryMock()
        let getMovieByIdUseCase = GetMovieDetailByIdUseCase(repository: movieRepository)
        let similarRepository = SimilarRepositoryMock()
        similarRepository.mockSimilarMoviesResponse = .init(results: [MovieDomainModel.mockData()])
        let getSimilarMoviesByIdUseCase = GetSimilarMoviesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepositoryMock()
        let getMovieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        viewModel = MovieDetailViewModel(
            getMovieByIdUseCase: getMovieByIdUseCase,
            getSimilarMoviesByIdUseCase: getSimilarMoviesByIdUseCase,
            getMovieVideoByIdUseCase: getMovieVideoByIdUseCase,
            movie: nil
        )

        try await viewModel?.fetchSimilar(movieId)
        XCTAssertFalse((viewModel?.similarList ?? []).isEmpty)
    }

    func testfetchSimilarWithInvalidMovieId() async throws {
        let movieRepository = MovieRepositoryMock()
        let getMovieByIdUseCase = GetMovieDetailByIdUseCase(repository: movieRepository)
        let similarRepository = SimilarRepositoryMock()
        similarRepository.mockSimilarMoviesResponse = .init(results: [MovieDto.mockData().toDomain()])
        let getSimilarMoviesByIdUseCase = GetSimilarMoviesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepositoryMock()
        let getMovieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        viewModel = MovieDetailViewModel(
            getMovieByIdUseCase: getMovieByIdUseCase,
            getSimilarMoviesByIdUseCase: getSimilarMoviesByIdUseCase,
            getMovieVideoByIdUseCase: getMovieVideoByIdUseCase,
            movie: nil
        )

        try await viewModel?.fetchSimilar(.zero)
        XCTAssertTrue((viewModel?.similarList ?? []).isEmpty)
    }

    func testfetchMovieDetail() async throws {
        let movieRepository = MovieRepositoryMock()
        let mockResponse = MovieDetailDto.mockData().toDomain()
        movieRepository.mockMovieDetailByIdResponse = mockResponse
        let getMovieByIdUseCase = GetMovieDetailByIdUseCase(repository: movieRepository)
        let similarRepository = SimilarRepositoryMock()
        let getSimilarMoviesByIdUseCase = GetSimilarMoviesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepositoryMock()
        let getMovieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        viewModel = MovieDetailViewModel(
            getMovieByIdUseCase: getMovieByIdUseCase,
            getSimilarMoviesByIdUseCase: getSimilarMoviesByIdUseCase,
            getMovieVideoByIdUseCase: getMovieVideoByIdUseCase,
            movie: nil
        )

        try await viewModel?.fetchMovieDetail(movieId)
        XCTAssertNotNil(viewModel?.currentMovie)
        XCTAssertEqual(viewModel?.currentMovie?.id, mockResponse.id)
    }

    func testfetchMovieDetailWithInvalidMovieId() async throws {
        let movieRepository = MovieRepositoryMock()
        let mockResponse = MovieDetailDto.mockData().toDomain()
        movieRepository.mockMovieDetailByIdResponse = mockResponse
        let getMovieByIdUseCase = GetMovieDetailByIdUseCase(repository: movieRepository)
        let similarRepository = SimilarRepositoryMock()
        let getSimilarMoviesByIdUseCase = GetSimilarMoviesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepositoryMock()
        let getMovieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        viewModel = MovieDetailViewModel(
            getMovieByIdUseCase: getMovieByIdUseCase,
            getSimilarMoviesByIdUseCase: getSimilarMoviesByIdUseCase,
            getMovieVideoByIdUseCase: getMovieVideoByIdUseCase,
            movie: nil
        )

        try await viewModel?.fetchMovieDetail(.zero)
        XCTAssertNil(viewModel?.currentMovie)
    }

    func testfetchVideo() async throws {
        let movieRepository = MovieRepositoryMock()
        let getMovieByIdUseCase = GetMovieDetailByIdUseCase(repository: movieRepository)
        let similarRepository = SimilarRepositoryMock()
        let getSimilarMoviesByIdUseCase = GetSimilarMoviesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepositoryMock()
        let getMovieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        viewModel = MovieDetailViewModel(
            getMovieByIdUseCase: getMovieByIdUseCase,
            getSimilarMoviesByIdUseCase: getSimilarMoviesByIdUseCase,
            getMovieVideoByIdUseCase: getMovieVideoByIdUseCase,
            movie: nil
        )

        try await viewModel?.fetchVideo(movieId)
        XCTAssertNotNil(viewModel?.videoDomainModel)
    }

    func testfetchVideoWithInvalidMovieId() async throws {
        let movieRepository = MovieRepositoryMock()
        let getMovieByIdUseCase = GetMovieDetailByIdUseCase(repository: movieRepository)
        let similarRepository = SimilarRepositoryMock()
        let getSimilarMoviesByIdUseCase = GetSimilarMoviesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepositoryMock()
        let getMovieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        viewModel = MovieDetailViewModel(
            getMovieByIdUseCase: getMovieByIdUseCase,
            getSimilarMoviesByIdUseCase: getSimilarMoviesByIdUseCase,
            getMovieVideoByIdUseCase: getMovieVideoByIdUseCase,
            movie: nil
        )

        try await viewModel?.fetchVideo(.zero)
        XCTAssertNil(viewModel?.videoDomainModel)
    }

    func testGetVideoId() async throws {
        let movieRepository = MovieRepositoryMock()
        let getMovieByIdUseCase = GetMovieDetailByIdUseCase(repository: movieRepository)
        let similarRepository = SimilarRepositoryMock()
        let getSimilarMoviesByIdUseCase = GetSimilarMoviesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepositoryMock()
        videoRepository.mockVideoByIdResponse = .init(results: [.init(name: "name", key: "key", type: .trailer)])
        let getMovieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        viewModel = MovieDetailViewModel(
            getMovieByIdUseCase: getMovieByIdUseCase,
            getSimilarMoviesByIdUseCase: getSimilarMoviesByIdUseCase,
            getMovieVideoByIdUseCase: getMovieVideoByIdUseCase,
            movie: nil
        )

        try await viewModel?.fetchVideo(movieId)
        let videoId =  viewModel?.getVideoId()
        XCTAssertNotNil(videoId)
    }

    func testGetVideoIdWithoutRequestVideoService()  {
        let movieRepository = MovieRepositoryMock()
        let getMovieByIdUseCase = GetMovieDetailByIdUseCase(repository: movieRepository)
        let similarRepository = SimilarRepositoryMock()
        let getSimilarMoviesByIdUseCase = GetSimilarMoviesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepositoryMock()
        let getMovieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        viewModel = MovieDetailViewModel(
            getMovieByIdUseCase: getMovieByIdUseCase,
            getSimilarMoviesByIdUseCase: getSimilarMoviesByIdUseCase,
            getMovieVideoByIdUseCase: getMovieVideoByIdUseCase,
            movie: nil
        )

        let videoId =  viewModel?.getVideoId()
        XCTAssertNil(videoId)
    }

    func testOnMoviePressed()  {
        let movie = MovieDto.mockData().toDomain()
        let movieRepository = MovieRepositoryMock()
        let getMovieByIdUseCase = GetMovieDetailByIdUseCase(repository: movieRepository)
        let similarRepository = SimilarRepositoryMock()
        let getSimilarMoviesByIdUseCase = GetSimilarMoviesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepositoryMock()
        let getMovieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        viewModel = MovieDetailViewModel(
            getMovieByIdUseCase: getMovieByIdUseCase,
            getSimilarMoviesByIdUseCase: getSimilarMoviesByIdUseCase,
            getMovieVideoByIdUseCase: getMovieVideoByIdUseCase,
            movie: nil
        )

        viewModel?.onMoviePressed(movie)
        XCTAssertNotNil(viewModel?.nextMovie)
        XCTAssertTrue(viewModel?.showSimilarMovieDetailView ?? false)
    }
}

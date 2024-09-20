//
//  SerieDetailViewModelTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class SerieDetailViewModelTests: XCTestCase {

    var viewModel: SerieDetailViewModel?
    let serieId = 61818

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testfetchData() async {
        let serieRepository = SerieRepositoryMock()
        let mockResponse = SerieDetailDomainModel.mockData()
        serieRepository.mockSerieDetailByIdResponse = mockResponse
        let getSerieByIdUseCase = GetSerieDetailByIdUseCase(repository: serieRepository)
        let similarRepository = SimilarRepositoryMock()
        similarRepository.mockSimilarSeriesResponse = .init(results: [SerieDomainModel.mockData()])
        let getSimilarSeriesByIdUseCase = GetSimilarSeriesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepositoryMock()
        let getSerieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        viewModel = SerieDetailViewModel(
            getSerieByIdUseCase: getSerieByIdUseCase,
            getSimilarSeriesByIdUseCase: getSimilarSeriesByIdUseCase,
            getSerieVideoByIdUseCase: getSerieVideoByIdUseCase,
            serie: nil
        )

        await viewModel?.fetchAllInformation(serieId: serieId)
        XCTAssertNotNil(viewModel?.currentSerie)
        XCTAssertEqual(viewModel?.currentSerie?.id, mockResponse.id)
        XCTAssertFalse((viewModel?.similarList ?? []).isEmpty)
        XCTAssertNotNil(viewModel?.videoDomainModel)
    }

    func testfetchSimilar() async throws {
        let serieRepository = SerieRepositoryMock()
        let getSerieByIdUseCase = GetSerieDetailByIdUseCase(repository: serieRepository)
        let similarRepository = SimilarRepositoryMock()
        similarRepository.mockSimilarSeriesResponse = .init(results: [SerieDto.mockData().toDomain()])
        let getSimilarSeriesByIdUseCase = GetSimilarSeriesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepositoryMock()
        let getSerieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        viewModel = SerieDetailViewModel(
            getSerieByIdUseCase: getSerieByIdUseCase,
            getSimilarSeriesByIdUseCase: getSimilarSeriesByIdUseCase,
            getSerieVideoByIdUseCase: getSerieVideoByIdUseCase,
            serie: nil
        )

        try await viewModel?.fetchSimilar(serieId)
        XCTAssertFalse((viewModel?.similarList ?? []).isEmpty)
    }

    func testfetchSimilarWithInvalidSerieId() async throws {
        let serieRepository = SerieRepositoryMock()
        let getSerieByIdUseCase = GetSerieDetailByIdUseCase(repository: serieRepository)
        let similarRepository = SimilarRepositoryMock()
        similarRepository.mockSimilarSeriesResponse = .init(results: [SerieDto.mockData().toDomain()])
        let getSimilarSeriesByIdUseCase = GetSimilarSeriesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepositoryMock()
        let getSerieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        viewModel = SerieDetailViewModel(
            getSerieByIdUseCase: getSerieByIdUseCase,
            getSimilarSeriesByIdUseCase: getSimilarSeriesByIdUseCase,
            getSerieVideoByIdUseCase: getSerieVideoByIdUseCase,
            serie: nil
        )

        try await viewModel?.fetchSimilar(.zero)
        XCTAssertTrue((viewModel?.similarList ?? []).isEmpty)
    }

    func testfetchSerieDetail() async throws {
        let serieRepository = SerieRepositoryMock()
        let mockResponse = SerieDetailDto.mockData().toDomain()
        serieRepository.mockSerieDetailByIdResponse = mockResponse
        let getSerieByIdUseCase = GetSerieDetailByIdUseCase(repository: serieRepository)
        let similarRepository = SimilarRepositoryMock()
        let getSimilarSeriesByIdUseCase = GetSimilarSeriesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepositoryMock()
        let getSerieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        viewModel = SerieDetailViewModel(
            getSerieByIdUseCase: getSerieByIdUseCase,
            getSimilarSeriesByIdUseCase: getSimilarSeriesByIdUseCase,
            getSerieVideoByIdUseCase: getSerieVideoByIdUseCase,
            serie: nil
        )

        try await viewModel?.fetchSerieDetail(serieId)
        XCTAssertNotNil(viewModel?.currentSerie)
        XCTAssertEqual(viewModel?.currentSerie?.id, mockResponse.id)
    }

    func testfetchSerieDetailWithInvalidSerieId() async throws {
        let serieRepository = SerieRepositoryMock()
        let mockResponse = SerieDetailDto.mockData().toDomain()
        serieRepository.mockSerieDetailByIdResponse = mockResponse
        let getSerieByIdUseCase = GetSerieDetailByIdUseCase(repository: serieRepository)
        let similarRepository = SimilarRepositoryMock()
        let getSimilarSeriesByIdUseCase = GetSimilarSeriesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepositoryMock()
        let getSerieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        viewModel = SerieDetailViewModel(
            getSerieByIdUseCase: getSerieByIdUseCase,
            getSimilarSeriesByIdUseCase: getSimilarSeriesByIdUseCase,
            getSerieVideoByIdUseCase: getSerieVideoByIdUseCase,
            serie: nil
        )

        try await viewModel?.fetchSerieDetail(.zero)
        XCTAssertNil(viewModel?.currentSerie)
    }

    func testfetchVideo() async throws {
        let serieRepository = SerieRepositoryMock()
        let getSerieByIdUseCase = GetSerieDetailByIdUseCase(repository: serieRepository)
        let similarRepository = SimilarRepositoryMock()
        let getSimilarSeriesByIdUseCase = GetSimilarSeriesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepositoryMock()
        let getSerieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        viewModel = SerieDetailViewModel(
            getSerieByIdUseCase: getSerieByIdUseCase,
            getSimilarSeriesByIdUseCase: getSimilarSeriesByIdUseCase,
            getSerieVideoByIdUseCase: getSerieVideoByIdUseCase,
            serie: nil
        )

        try await viewModel?.fetchVideo(serieId)
        XCTAssertNotNil(viewModel?.videoDomainModel)
    }

    func testfetchVideoWithInvalidSerieId() async throws {
        let serieRepository = SerieRepositoryMock()
        let getSerieByIdUseCase = GetSerieDetailByIdUseCase(repository: serieRepository)
        let similarRepository = SimilarRepositoryMock()
        let getSimilarSeriesByIdUseCase = GetSimilarSeriesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepositoryMock()
        let getSerieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        viewModel = SerieDetailViewModel(
            getSerieByIdUseCase: getSerieByIdUseCase,
            getSimilarSeriesByIdUseCase: getSimilarSeriesByIdUseCase,
            getSerieVideoByIdUseCase: getSerieVideoByIdUseCase,
            serie: nil
        )

        try await viewModel?.fetchVideo(.zero)
        XCTAssertNil(viewModel?.videoDomainModel)
    }

    func testGetVideoId() async throws {
        let serieRepository = SerieRepositoryMock()
        let getSerieByIdUseCase = GetSerieDetailByIdUseCase(repository: serieRepository)
        let similarRepository = SimilarRepositoryMock()
        let getSimilarSeriesByIdUseCase = GetSimilarSeriesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepositoryMock()
        videoRepository.mockVideoByIdResponse = .init(results: [.init(name: "name", key: "key", type: .trailer)])
        let getSerieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        viewModel = SerieDetailViewModel(
            getSerieByIdUseCase: getSerieByIdUseCase,
            getSimilarSeriesByIdUseCase: getSimilarSeriesByIdUseCase,
            getSerieVideoByIdUseCase: getSerieVideoByIdUseCase,
            serie: nil
        )

        try await viewModel?.fetchVideo(serieId)
        let videoId =  viewModel?.getVideoId()
        XCTAssertNotNil(videoId)
    }

    func testGetVideoIdWithoutRequestVideoService()  {
        let serieRepository = SerieRepositoryMock()
        let getSerieByIdUseCase = GetSerieDetailByIdUseCase(repository: serieRepository)
        let similarRepository = SimilarRepositoryMock()
        let getSimilarSeriesByIdUseCase = GetSimilarSeriesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepositoryMock()
        let getSerieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        viewModel = SerieDetailViewModel(
            getSerieByIdUseCase: getSerieByIdUseCase,
            getSimilarSeriesByIdUseCase: getSimilarSeriesByIdUseCase,
            getSerieVideoByIdUseCase: getSerieVideoByIdUseCase,
            serie: nil
        )

        let videoId =  viewModel?.getVideoId()
        XCTAssertNil(videoId)
    }

    func testOnSeriePressed()  {
        let serie = SerieDto.mockData().toDomain()
        let serieRepository = SerieRepositoryMock()
        let getSerieByIdUseCase = GetSerieDetailByIdUseCase(repository: serieRepository)
        let similarRepository = SimilarRepositoryMock()
        let getSimilarSeriesByIdUseCase = GetSimilarSeriesByIdUseCase(repository: similarRepository)
        let videoRepository = VideoRepositoryMock()
        let getSerieVideoByIdUseCase = GetVideoByIdUseCase(repository: videoRepository)
        viewModel = SerieDetailViewModel(
            getSerieByIdUseCase: getSerieByIdUseCase,
            getSimilarSeriesByIdUseCase: getSimilarSeriesByIdUseCase,
            getSerieVideoByIdUseCase: getSerieVideoByIdUseCase,
            serie: nil
        )

        viewModel?.onSeriePressed(serie)
        XCTAssertNotNil(viewModel?.nextSerie)
        XCTAssertTrue(viewModel?.showSimilarSerieDetailView ?? false)
    }
}

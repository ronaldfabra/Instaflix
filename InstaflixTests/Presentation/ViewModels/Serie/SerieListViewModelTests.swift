//
//  SerieListViewModelTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class SerieListViewModelTests: XCTestCase {

    var viewModel: SerieListViewModel?

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testfetchData() async {
        let serieRepository = SerieRepositoryMock()
        let serieResponse = SerieDto.mockData().toDomain()
        serieRepository.mockSeriesResponse = .init(results: [serieResponse])
        let getSerieByCategoryUseCase = GetSerieByCategoryUseCase(repository: serieRepository)
        viewModel = SerieListViewModel(getSerieByCategoryUseCase: getSerieByCategoryUseCase)

        await viewModel?.fetchAllSeries()
        XCTAssertNotNil(viewModel?.categories)
        XCTAssertNotNil(viewModel?.categories.first)
        XCTAssertEqual(viewModel?.categories.first?.list.count, 1)
        XCTAssertEqual(viewModel?.categories.first?.list.first?.id, serieResponse.id)
    }

    func testfetchDataWithInvalidPage() async throws {
        let serieRepository = SerieRepositoryMock()
        let serieResponse = SerieDto.mockData().toDomain()
        serieRepository.mockSeriesResponse = .init(results: [serieResponse])
        let getSerieByCategoryUseCase = GetSerieByCategoryUseCase(repository: serieRepository)
        viewModel = SerieListViewModel(getSerieByCategoryUseCase: getSerieByCategoryUseCase)
        if let category = viewModel?.categories.first, ((viewModel?.categories.indices.contains(0)) != nil) {
            viewModel?.categories[0].page = -1
            await viewModel?.fetchSeries(by: category)
            XCTAssertTrue((viewModel?.categories.first?.list ?? []).isEmpty)
        }

    }

    func testOnSeriePressed()  {
        let serie = SerieDto.mockData().toDomain()
        let serieRepository = SerieRepositoryMock()
        let getSerieByCategoryUseCase = GetSerieByCategoryUseCase(repository: serieRepository)
        viewModel = SerieListViewModel(getSerieByCategoryUseCase: getSerieByCategoryUseCase)

        viewModel?.onSeriePressed(serie)
        XCTAssertNotNil(viewModel?.serieSelected)
        XCTAssertTrue(viewModel?.showSerieDetailView ?? false)
    }

    func testOnPaginateIfNeeded() async {
        let serieRepository = SerieRepositoryMock()
        let serieResponse = SerieDto.mockData().toDomain()
        serieRepository.mockSeriesResponse = .init(results: [serieResponse])
        let getSerieByCategoryUseCase = GetSerieByCategoryUseCase(repository: serieRepository)
        viewModel = SerieListViewModel(getSerieByCategoryUseCase: getSerieByCategoryUseCase)
        var category = viewModel?.categories.first ?? CategoryDomailModel<SerieDomainModel>(category: .popular, totalPages: 1, list: [])
        category.totalPages = 1
        await viewModel?.onPaginateIfNeeded(category: category)
        XCTAssertFalse((viewModel?.categories.first?.list ?? []).isEmpty)
    }
}

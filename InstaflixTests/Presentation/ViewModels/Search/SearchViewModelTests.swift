//
//  SearchViewModelTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class SearchViewModelTests: XCTestCase {

    var viewModel: SearchViewModel?

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testfetchData() async {
        let multiRepository = MultiRepositoryMock()
        let multiResponse = MultiDomainModel.mockData()
        multiRepository.mockSearchResponse = .init(results: [multiResponse])
        let getSearchUseCase = GetSearchUseCase(repository: multiRepository)
        viewModel = SearchViewModel(getSearchUseCase: getSearchUseCase)
        await viewModel?.fetchItems(by: "qiery")
        XCTAssertNotNil(viewModel?.list)
        XCTAssertFalse(viewModel?.list.isEmpty ?? true)
        XCTAssertEqual(viewModel?.list.count, 1)
        XCTAssertEqual(viewModel?.list.first?.id, multiResponse.id)
    }

    func testfetchDataWithEmptyQuey() async throws {
        let multiRepository = MultiRepositoryMock()
        let getSearchUseCase = GetSearchUseCase(repository: multiRepository)
        viewModel = SearchViewModel(getSearchUseCase: getSearchUseCase)
        await viewModel?.fetchItems(by: .empty)
        XCTAssertNotNil(viewModel?.list)
        XCTAssertTrue(viewModel?.list.isEmpty ?? true)
        XCTAssertEqual(viewModel?.list.count, 0)
    }

    func testOnMoviePressed() {
        let multiRepository = MultiRepositoryMock()
        let multiResponse = MultiDomainModel.mockData(mediaType: .movie)
        let getSearchUseCase = GetSearchUseCase(repository: multiRepository)
        viewModel = SearchViewModel(getSearchUseCase: getSearchUseCase)
        viewModel?.onItemPressed(multiResponse)
        XCTAssertNotNil(viewModel?.mediaSelected)
        XCTAssertTrue(viewModel?.showMovieDetailView ?? false)
    }

    func testOnSeriePressed() {
        let multiRepository = MultiRepositoryMock()
        let multiResponse = MultiDomainModel.mockData(mediaType: .serie)
        let getSearchUseCase = GetSearchUseCase(repository: multiRepository)
        viewModel = SearchViewModel(getSearchUseCase: getSearchUseCase)
        viewModel?.onItemPressed(multiResponse)
        XCTAssertNotNil(viewModel?.mediaSelected)
        XCTAssertTrue(viewModel?.showSerieDetailView ?? false)
    }

    func testFetchBy() async {
        let multiRepository = MultiRepositoryMock()
        let multiResponse = MultiDomainModel.mockData()
        multiRepository.mockSearchResponse = .init(results: [multiResponse])
        let getSearchUseCase = GetSearchUseCase(repository: multiRepository)
        viewModel = SearchViewModel(getSearchUseCase: getSearchUseCase)
        await viewModel?.fetchBy(query: "query")
        XCTAssertNotNil(viewModel?.list)
        XCTAssertFalse(viewModel?.list.isEmpty ?? true)
        XCTAssertEqual(viewModel?.list.count, 1)
        XCTAssertEqual(viewModel?.list.first?.id, multiResponse.id)
    }

    func testFetchByWithEmptyQuey() async {
        let multiRepository = MultiRepositoryMock()
        let getSearchUseCase = GetSearchUseCase(repository: multiRepository)
        viewModel = SearchViewModel(getSearchUseCase: getSearchUseCase)
        await viewModel?.fetchBy(query: .empty)
        XCTAssertNotNil(viewModel?.list)
        XCTAssertTrue(viewModel?.list.isEmpty ?? true)
        XCTAssertEqual(viewModel?.list.count, 0)
    }
}

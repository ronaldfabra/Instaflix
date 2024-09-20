//
//  ItemInformationViewModelTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class ItemInformationViewModelTests: XCTestCase {

    var viewModel: ItemInformationViewModel?

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testShouldDisplayText() {
        let multiRepository = MultiRepositoryMock()
        let setFavoriteMovieUseCase = SetFavoriteUseCase(repository: multiRepository)
        viewModel = ItemInformationViewModel(setFavoriteMovieUseCase: setFavoriteMovieUseCase, 
                                             itemModel: nil,
                                             mediaType: .movie)

        let shouldDisplayText = viewModel?.shouldDisplayText(text: nil) ?? true
        XCTAssertFalse(shouldDisplayText)
        let shouldDisplayTextTrue = viewModel?.shouldDisplayText(text: "nil") ?? false
        XCTAssertTrue(shouldDisplayTextTrue)
    }

    func testGetAgeRecommended() {
        var itemModel = SerieDomainModel.mockData()
        itemModel.adult = true
        let multiRepository = MultiRepositoryMock()
        let setFavoriteMovieUseCase = SetFavoriteUseCase(repository: multiRepository)
        viewModel = ItemInformationViewModel(setFavoriteMovieUseCase: setFavoriteMovieUseCase,
                                             itemModel: itemModel,
                                             mediaType: .movie)

        let ageRecommendedAdult = viewModel?.getAgeRecommended(itemModel: itemModel)
        XCTAssertEqual(ageRecommendedAdult, ItemInformationViewConstants.Strings.adultAgeRecommended)
        itemModel.adult = false
        let ageRecommendedGeneral = viewModel?.getAgeRecommended(itemModel: SerieDomainModel.mockData())
        XCTAssertEqual(ageRecommendedGeneral, ItemInformationViewConstants.Strings.generalAgeRecommended)
    }

    func testGetSerieDuration() {
        let itemModel = SerieDetailDomainModel.mockData()
        let multiRepository = MultiRepositoryMock()
        let setFavoriteMovieUseCase = SetFavoriteUseCase(repository: multiRepository)
        viewModel = ItemInformationViewModel(setFavoriteMovieUseCase: setFavoriteMovieUseCase,
                                             itemModel: itemModel,
                                             mediaType: .movie)

        let serieDuration = viewModel?.getItemDuration(itemModel: itemModel, mediaType: .serie)
        XCTAssertEqual(serieDuration, String(format: ItemInformationViewConstants.Strings.seasons, itemModel.numberOfSeasons ?? .zero))
    }

    func testGetMovieDuration() {
        let itemModel = MovieDetailDomainModel.mockData()
        let multiRepository = MultiRepositoryMock()
        let setFavoriteMovieUseCase = SetFavoriteUseCase(repository: multiRepository)
        viewModel = ItemInformationViewModel(setFavoriteMovieUseCase: setFavoriteMovieUseCase,
                                             itemModel: itemModel,
                                             mediaType: .movie)

        let movieDuration = viewModel?.getItemDuration(itemModel: itemModel, mediaType: .movie)
        XCTAssertEqual(movieDuration, InstaflixUtils.convertMinutesToHours(minutes: itemModel.runtime ?? .zero))
    }

    func testSetFavorite() {
        let itemModel = MovieDetailDomainModel.mockData()
        let multiRepository = MultiRepositoryMock()
        let setFavoriteMovieUseCase = SetFavoriteUseCase(repository: multiRepository)
        viewModel = ItemInformationViewModel(setFavoriteMovieUseCase: setFavoriteMovieUseCase,
                                             itemModel: itemModel,
                                             mediaType: .movie)
        viewModel?.setFavorite(itemId: itemModel.id, isFavorite: true, mediaType: .movie)
        XCTAssertTrue(viewModel?.itemModel?.isFavorite ?? false)
    }

    func testSetFavoriteFalse() {
        let itemModel = MovieDetailDomainModel.mockData()
        let multiRepository = MultiRepositoryMock()
        let setFavoriteMovieUseCase = SetFavoriteUseCase(repository: multiRepository)
        viewModel = ItemInformationViewModel(setFavoriteMovieUseCase: setFavoriteMovieUseCase,
                                             itemModel: itemModel,
                                             mediaType: .movie)
        viewModel?.setFavorite(itemId: itemModel.id, isFavorite: false, mediaType: .movie)
        XCTAssertFalse(viewModel?.itemModel?.isFavorite ?? true)
    }

    func testUpdateItemModel() {
        var itemModel = MovieDetailDomainModel.mockData()
        let multiRepository = MultiRepositoryMock()
        let setFavoriteMovieUseCase = SetFavoriteUseCase(repository: multiRepository)
        viewModel = ItemInformationViewModel(setFavoriteMovieUseCase: setFavoriteMovieUseCase,
                                             itemModel: itemModel,
                                             mediaType: .movie)
        itemModel.title = "new title"
        viewModel?.updateItemModel(itemModel: itemModel)
        XCTAssertEqual(viewModel?.itemModel?.title, itemModel.title)
    }
}

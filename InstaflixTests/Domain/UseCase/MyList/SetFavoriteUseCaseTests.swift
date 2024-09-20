//
//  SetFavoriteUseCaseTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class SetFavoriteUseCaseTests: XCTestCase {
    var usecase: SetFavoriteUseCaseProtocol?
    let itemId = 61818

    override func tearDownWithError() throws {
        usecase = nil
    }

    func testSetData() async throws {
        let multiRepository = MultiRepositoryMock()
        usecase = SetFavoriteUseCase(repository: multiRepository)
        usecase?.execute(itemId: itemId, isFavorite: true, mediaType: .movie)
        XCTAssertTrue(multiRepository.itemIsFavorite)
    }

    func testSetDataisNotFavorite() async throws {
        let multiRepository = MultiRepositoryMock()
        usecase = SetFavoriteUseCase(repository: multiRepository)
        usecase?.execute(itemId: itemId, isFavorite: false, mediaType: .movie)
        XCTAssertFalse(multiRepository.itemIsFavorite)
    }

    func testSetDataWithInvalidItemId() async throws {
        let multiRepository = MultiRepositoryMock()
        usecase = SetFavoriteUseCase(repository: multiRepository)
        usecase?.execute(itemId: 0, isFavorite: true, mediaType: .movie)
        XCTAssertFalse(multiRepository.itemIsFavorite)
    }
}

//
//  GetMyListSerieUseCaseTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix
import XCTest

final class GetMyListSerieUseCaseTests: XCTestCase {
    var usecase: GetMyListSerieUseCaseProtocol?
    let itemId = 61818

    override func tearDownWithError() throws {
        usecase = nil
    }

    func testfetchData(){
        let serieRepository = SerieRepositoryMock()
        let serieResponse = SerieDto.mockData().toDomain()
        serieRepository.mockAllFavoritesSeriesResponse = [serieResponse]
        usecase = GetMyListSerieUseCase(repository: serieRepository)
        let response = usecase?.execute()
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.count, 1)
        XCTAssertEqual(response?.first?.id, serieResponse.id)
    }

    func testfetchDataWithoutFavorites() {
        let serieRepository = SerieRepositoryMock()
        usecase = GetMyListSerieUseCase(repository: serieRepository)
        let response = usecase?.execute()
        XCTAssertNotNil(response)
        XCTAssertTrue(response?.isEmpty ?? false)
    }
}

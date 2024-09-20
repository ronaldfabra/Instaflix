//
//  InstaflixUtilsTests.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 20/09/24.
//

@testable import Instaflix
import XCTest

final class InstaflixUtilsTests: XCTestCase {

    func testConvertMinutesToHours() {
        let hours = InstaflixUtils.convertMinutesToHours(minutes: 10)
        XCTAssertEqual(hours, "10 minutes")
    }

    func testConvertMinutesToHours2() {
        let hours = InstaflixUtils.convertMinutesToHours(minutes: 60)
        XCTAssertEqual(hours, "1 hour")
    }

    func testIsRecentlyAdded() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr = dateFormatter.string(from: Date())
        let isRecentlyAdded = InstaflixUtils.isRecentlyAdded(dateStr: dateStr)
        XCTAssertTrue(isRecentlyAdded)
    }

    func testIsNotRecentlyAdded() {
        let previousMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date()) ?? Date()
        let dateFormatter = DateFormatter()
        let isRecentlyAdded = InstaflixUtils.isRecentlyAdded(dateStr: dateFormatter.string(from: previousMonth))
        XCTAssertFalse(isRecentlyAdded)
    }

    func testGetYear() {
        let year = InstaflixUtils.getYear(from: "2024-12-12")
        XCTAssertEqual(year, "2024")
    }

    func testGetImageUrlForPoster() {
        let filePath = "/dfX2UaHVE5c7kLBFbgmEZJuy4Ev.jpg"
        let expectedUrl = String(format: InstaflixContants.InstaflixURL.immage, InstaflixContants.ImageSize.w200, filePath)
        let url = InstaflixUtils.getImageUrl(filePath: filePath, type: .poster)
        XCTAssertEqual(url?.absoluteString, expectedUrl)
    }

    func testGetImageUrlForBackdropPath() {
        let filePath = "/dfX2UaHVE5c7kLBFbgmEZJuy4Ev.jpg"
        let expectedUrl = String(format: InstaflixContants.InstaflixURL.immage, InstaflixContants.ImageSize.original, filePath)
        let url = InstaflixUtils.getImageUrl(filePath: filePath, type: .backdropPath)
        XCTAssertEqual(url?.absoluteString, expectedUrl)
    }
}

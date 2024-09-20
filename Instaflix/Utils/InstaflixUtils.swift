//
//  InstaflixUtils.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 18/09/24.
//

import Foundation

class InstaflixUtils {
    static func getImageUrl(filePath: String?, type: InstaflixImageType) -> URL? {
        guard let filePath else { return nil }
        var imageSize: String
        switch type {
            case .backdropPath:
                imageSize = InstaflixContants.ImageSize.original
            case .poster:
                imageSize = InstaflixContants.ImageSize.w200
        }
        let urlString = String(format: InstaflixContants.InstaflixURL.immage, imageSize, filePath)
        return URL(string: urlString)
    }

    static func getGeneralHeaders() -> [String: String] {
        var headers: [String: String] = [:]
        headers[InstaflixContants.Headers.acceptKey] = InstaflixContants.Headers.acceptValue
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
        headers[InstaflixContants.Headers.authorizationKey] = String(format: "Bearer %@", apiKey  ?? .empty)
        return headers
    }

    static func getYear(from dateStr: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateStr) else { return .empty }
        dateFormatter.dateFormat = "yyyy"
        let currentYearString = dateFormatter.string(from: date)
        return currentYearString
    }

    static func isRecentlyAdded(dateStr: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateStr) else { return false }
        return date.isInSameMonth(as: Date())
    }

    static func convertMinutesToHours(minutes: Int) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        let timeFormatted = formatter.string(from: TimeInterval(minutes * 60))
        return timeFormatted
    }
}

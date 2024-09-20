//
//  SerieEndpoint.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

enum SerieEndpoint {
    case serieByCategory(String, Int)
    case serieDetailById(Int)
    case serieSimilarById(Int, Int)
}

extension SerieEndpoint: EndPointProtocol {
    var baseUrl: String {
        InstaflixContants.InstaflixURL.baseURL
    }

    var apiVersion: String {
        InstaflixContants.InstaflixURL.apiVerion
    }

    var relativeURL: String {
        switch self {
            case .serieByCategory(let category, _):
                return "tv/\(category)"
            case .serieDetailById(let id):
                return "tv/\(id)"
            case .serieSimilarById(let id, _):
                return "tv/\(id)/similar"
        }
    }

    var headers: [String: String] {
        InstaflixUtils.getGeneralHeaders()
    }

    var method: String {
        return URLRequestMethod.get.rawValue
    }

    var urlString: String {
        switch self {
            case .serieByCategory, .serieDetailById, .serieSimilarById:
                return "\(baseUrl)/\(apiVersion)/\(relativeURL)"
        }
    }

    var parameters: [String: Any] {
        var params: [String: Any] = [:]
        switch self {
            case .serieByCategory(_, let page):
                params["page"] = page
            case .serieSimilarById(_, let page):
                params["page"] = page
            default:
                break
        }
        return params
    }
}


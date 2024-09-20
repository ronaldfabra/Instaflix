//
//  MovieEndpoint.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

enum MovieEndpoint {
    case movieByCategory(String, Int)
    case movieDetailById(Int)
    case movieSimilarById(Int, Int)
}

extension MovieEndpoint: EndPointProtocol {
    var baseUrl: String {
        InstaflixContants.InstaflixURL.baseURL
    }

    var apiVersion: String {
        InstaflixContants.InstaflixURL.apiVerion
    }

    var relativeURL: String {
        switch self {
            case .movieByCategory(let category, _):
                return "movie/\(category)"
            case .movieDetailById(let id):
                return "movie/\(id)"
            case .movieSimilarById(let id, _):
                return "movie/\(id)/similar"
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
            case .movieByCategory, .movieDetailById, .movieSimilarById:
                return "\(baseUrl)/\(apiVersion)/\(relativeURL)"
        }
    }

    var parameters: [String: Any] {
        var params: [String: Any] = [:]
        switch self {
            case .movieByCategory(_, let page):
                params["page"] = page
            case .movieSimilarById(_, let page):
                params["page"] = page
            default:
                break
        }
        return params
    }
}

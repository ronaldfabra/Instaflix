//
//  MultiEndpoint.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

enum MultiEndpoint {
    case itemsByQuery(String, Int)
}

extension MultiEndpoint: EndPointProtocol {
    var baseUrl: String {
        InstaflixContants.InstaflixURL.baseURL
    }

    var apiVersion: String {
        InstaflixContants.InstaflixURL.apiVerion
    }

    var relativeURL: String {
        switch self {
            case .itemsByQuery:
                return "search/multi"
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
            case .itemsByQuery:
                return "\(baseUrl)/\(apiVersion)/\(relativeURL)"
        }
    }

    var parameters: [String: Any] {
        var params: [String: Any] = [:]
        switch self {
            case .itemsByQuery(let query, let page):
                params["query"] = query
                params["page"] = page
        }
        return params
    }
}

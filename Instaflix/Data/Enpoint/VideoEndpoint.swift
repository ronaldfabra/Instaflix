//
//  VideoEndpoint.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

enum VideoEndpoint {
    case videoById(Int, String)
}

extension VideoEndpoint: EndPointProtocol {
    var baseUrl: String {
        InstaflixContants.InstaflixURL.baseURL
    }

    var apiVersion: String {
        InstaflixContants.InstaflixURL.apiVerion
    }

    var relativeURL: String {
        switch self {
            case .videoById(let id, let path):
                return "\(path)/\(id)/videos"
        }
    }

    var headers: [String: String] {
        InstaflixUtils.getGeneralHeaders()
    }

    var method: String {
        URLRequestMethod.get.rawValue
    }

    var urlString: String {
        switch self {
            case .videoById:
                return "\(baseUrl)/\(apiVersion)/\(relativeURL)"
        }
    }

    var parameters: [String: Any] {
        return [:]
    }
}

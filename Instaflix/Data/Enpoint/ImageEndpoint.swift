//
//  ImageEndpoint.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

enum ImageEndpoint {
    case imageById(Int, String)
}

extension ImageEndpoint: EndPointProtocol {
    var baseUrl: String {
        InstaflixContants.InstaflixURL.baseURL
    }

    var apiVersion: String {
        InstaflixContants.InstaflixURL.apiVerion
    }

    var relativeURL: String {
        switch self {
            case .imageById(let id, let path):
                return "\(path)/\(id)/images"
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
            case .imageById:
                return "\(baseUrl)/\(apiVersion)/\(relativeURL)"
        }
    }

    var parameters: [String: Any] {
        return [:]
    }
}

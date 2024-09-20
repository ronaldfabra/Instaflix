//
//  NetworkErrorType.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Foundation

public enum NetworkErrorType: LocalizedError, Equatable {
    case invalidURL
    case serverError
    case invalidData
    case internetConnection
    case unkown(Error)
    case none


    public static func == (lhs: NetworkErrorType, rhs: NetworkErrorType) -> Bool {
        lhs.errorDescription == rhs.errorDescription
    }

    public var errorDescription: String {
        switch self {
            case .invalidURL:
                return InstaflixContants.Strings.NetworkError.invalidURL.capitalized
            case .serverError:
                return InstaflixContants.Strings.NetworkError.serverError.capitalized
            case .invalidData:
                return InstaflixContants.Strings.NetworkError.invalidData.capitalized
            case .internetConnection:
                return InstaflixContants.Strings.NetworkError.internetConnection.capitalized
            case .unkown(let error):
                return error.localizedDescription
            case .none:
                return .empty
        }
    }
}

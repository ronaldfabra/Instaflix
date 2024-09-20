//
//  NetworkMock.swift
//  InstaflixTests
//
//  Created by Ronal Andres Fabra Jimenez on 19/09/24.
//

@testable import Instaflix

class NetworkMock<T: Decodable>: NetworkProtocol {

    var mockResponse: T? = nil

    func request<T: Decodable>(endPoint: EndPointProtocol, type _: T.Type) async throws -> T {
        if let mockResponse =  mockResponse as? T {
            return mockResponse
        } else {
            throw NetworkErrorType.invalidData
        }
    }
}

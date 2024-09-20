//
//  Network.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Combine
import Foundation

protocol NetworkProtocol {
    func request<T: Decodable>(endPoint: EndPointProtocol, type _: T.Type) async throws -> T
}

public class Network: NetworkProtocol {
    public static let shared = Network()

    func request<T: Decodable>(endPoint: EndPointProtocol, type _: T.Type) async throws -> T {
        do {
            guard let urlCompponent = NSURLComponents(string: endPoint.urlString) else { throw NetworkErrorType.invalidURL }
            var items = [URLQueryItem]()
            for queryParam in endPoint.parameters {
                items.append(URLQueryItem(name: queryParam.key, value: "\(queryParam.value)"))
            }
            items = items.filter{!$0.name.isEmpty}
            if !items.isEmpty {
                urlCompponent.queryItems = items
            }
            guard let url = urlCompponent.url else { throw NetworkErrorType.invalidURL }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = endPoint.method
            urlRequest.allHTTPHeaderFields = endPoint.headers
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == ResponseStatusType.success.rawValue else { throw NetworkErrorType.serverError }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            guard let model = try? decoder.decode(T.self, from: data) else { throw NetworkErrorType.invalidData }
            return model
        } catch let error as NSError {
            if error.code < ResponseStatusType.success.rawValue {
                throw NetworkErrorType.internetConnection
            } else {
                throw NetworkErrorType.generalError
            }
        } catch {
            throw NetworkErrorType.unkown(error)
        }
    }
}

enum ResponseStatusType: Int {
    case success = 200
}

//
//  DTOProtocol.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

protocol DTOProtocolDecodable: Decodable & DomainModelable {}
protocol DTOProtocol: Codable & DomainModelable {}

protocol DomainModelable {
    associatedtype DomainModel

    func toDomain() throws -> DomainModel
}

extension Array where Element: DomainModelable {
    func toDomain() throws -> [Element.DomainModel] {
        try map { try $0.toDomain() }
    }
}

//
//  ItemDomailModelProtocol.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Foundation

protocol ItemDomailModelProtocol: Identifiable {
    var id: Int { get set }
    var name: String? { get set }
    var posterPath: String? { get set }
    var backdropPath: String? { get set }
}

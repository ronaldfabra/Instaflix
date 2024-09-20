//
//  SimilarRepositoryProtocol.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Combine
import Foundation

protocol SimilarRepositoryProtocol {
    func getSimilarSeriesById(id: Int, page: Int) async throws -> BaseDomailModel<SerieDomainModel>
    func getSimilarMoviesById(id: Int, page: Int) async throws -> BaseDomailModel<MovieDomainModel> 
}

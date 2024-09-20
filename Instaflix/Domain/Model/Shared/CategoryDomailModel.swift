//
//  CategoryDomailModel.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Foundation

struct CategoryDomailModel<T: Identifiable & Decodable>: Identifiable, Equatable {
    var id: UUID
    let category: CategoryType
    var page: Int
    var totalPages: Int
    var isPendingRequest: Bool
    var list: [T]

    init(id: UUID = UUID(), category: CategoryType, page: Int = 0, totalPages: Int = 0, isPendingRequest: Bool = false, list: [T]) {
        self.id = id
        self.category = category
        self.page = page
        self.totalPages = totalPages
        self.isPendingRequest = isPendingRequest
        self.list = list
    }

    static func == (lhs: CategoryDomailModel<T>, rhs: CategoryDomailModel<T>) -> Bool {
        lhs.id == rhs.id &&
        lhs.page == rhs.page &&
        lhs.totalPages == rhs.totalPages &&
        lhs.isPendingRequest == rhs.isPendingRequest &&
        lhs.category == rhs.category
    }
}

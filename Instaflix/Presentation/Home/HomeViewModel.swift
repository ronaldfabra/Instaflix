//
//  HomeViewModel.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Combine
import Foundation

@Observable
class HomeViewModel: ObservableObject {
    var filters: [FilterDomainModel] = [.init(title: MediaType.serie.filterTitle, isDropdown: false),
                                  .init(title: MediaType.movie.filterTitle, isDropdown: false)]
    var selectedFilter: FilterDomainModel? = nil
    var showSearchView: Bool = false
}

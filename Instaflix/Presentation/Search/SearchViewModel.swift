//
//  SearchViewModel.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 14/09/24.
//

import Combine
import Foundation

@Observable
class SearchViewModel: ObservableObject {
    private let getSearchUseCase: GetSearchUseCaseProtocol
    var list: [MultiDomainModel] = []
    var showSerieDetailView: Bool = false
    var showMovieDetailView: Bool = false
    var mediaSelected: (any ItemInformationProtocol)?
    private var page = 0
    private var totalPages = 1
    private var currentQuery = ""
    var error: NetworkErrorType = .none

    init(getSearchUseCase: GetSearchUseCaseProtocol) {
        self.getSearchUseCase = getSearchUseCase
    }

    @MainActor
    func fetchItems(by query: String) async {
        if totalPages > page {
            page += 1
            do {
                let response = try await getSearchUseCase.execute(query: query, page: page)
                handleSuccess(response: response)
            } catch {
                handleError(error: error)
            }
        }
    }

    private func handleSuccess(response: BaseDomailModel<MultiDomainModel>) {
        totalPages = response.totalPages
        self.list.append(contentsOf: response.results)
    }

    private func handleError(error: Error) {
        if let error = error as? NetworkErrorType {
            self.error = error
        } else {
            self.error = .unkown(error)
        }
    }
}

extension SearchViewModel {
    func onItemPressed(_ media: MultiDomainModel) {
        mediaSelected = media
        if mediaSelected != nil {
            switch media.mediaType {
                case .movie:
                    showMovieDetailView = true
                case .serie:
                    showSerieDetailView = true
                case .none:
                    break
            }
        }
    }

    func fetchBy(query: String) async {
        if currentQuery != query || query.isEmpty {
            page = 0
            currentQuery = query
            self.list.removeAll()
        }
        await fetchItems(by: query)
    }
}

//
//  SerieListViewModel.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Combine
import Foundation

@Observable
class SerieListViewModel: ObservableObject {
    private let getSerieByCategoryUseCase: GetSerieByCategoryUseCaseProtocol
    var categories: [CategoryDomailModel<SerieDomainModel>] = [
        CategoryDomailModel(category: .airingToday, list: []),
        CategoryDomailModel(category: .onTheAir, list: []),
        CategoryDomailModel(category: .popular, list: []),
        CategoryDomailModel(category: .topRatedCategory, list: [])
    ]
    var showSerieDetailView: Bool = false
    var serieSelected: SerieDomainModel?
    var showSkeleton: Bool = false
    var error: NetworkErrorType = .none

    init(getSerieByCategoryUseCase: GetSerieByCategoryUseCaseProtocol) {
        self.getSerieByCategoryUseCase = getSerieByCategoryUseCase
    }

    @MainActor
    func fetchSeries(by category: CategoryDomailModel<SerieDomainModel>) async {
        guard let categoryIndex = categories.firstIndex(where: { $0.category == category.category }) else { return }
        categories[categoryIndex].page += 1
        categories[categoryIndex].isPendingRequest = true
        let categoryModel = categories[categoryIndex]
        do {
            let response = try await getSerieByCategoryUseCase.execute(category: categoryModel.category.categoryName, 
                                                                       page: categoryModel.page)
            handleSuccess(categoryIndex: categoryIndex, response: response)
        } catch {
            handleError(error: error)
        }
        showSkeleton = false
    }

    @MainActor
    private func handleSuccess(categoryIndex: Int, response: BaseDomailModel<SerieDomainModel>) {
        categories[categoryIndex].isPendingRequest = false
        categories[categoryIndex].totalPages = response.totalPages
        categories[categoryIndex].list.append(contentsOf: response.results)
    }

    private func handleError(error: Error) {
        if let error = error as? NetworkErrorType {
            self.error = error
        } else {
            self.error = .unkown(error)
        }
    }
}

extension SerieListViewModel {
    @MainActor
    func fetchAllSeries() async {
        showSkeleton = true
        for category in categories {
            await fetchSeries(by: category)
        }
    }

    func onSeriePressed(_ serie: SerieDomainModel) {
        serieSelected = serie
        showSerieDetailView = true
    }

    @MainActor
    func onPaginateIfNeeded(category: CategoryDomailModel<SerieDomainModel>) async {
        if category.page < category.totalPages {
            await fetchSeries(by: category)
        }
    }
}

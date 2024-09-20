//
//  MovieListViewModel.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 13/09/24.
//

import Combine
import Foundation

@Observable
class MovieListViewModel: ObservableObject {
    private let getMovieByCategoryUseCase: GetMovieByCategoryUseCaseProtocol
    var categories: [CategoryDomailModel<MovieDomainModel>] = [
        CategoryDomailModel(category: .nowPlaying, list: []),
        CategoryDomailModel(category: .popular, list: []),
        CategoryDomailModel(category: .topRatedCategory, list: []),
        CategoryDomailModel(category: .upcoming, list: [])
    ]
    var showMovieDetailView: Bool = false
    var movieSelected: MovieDomainModel?
    var showSkeleton: Bool = false
    var error: NetworkErrorType = .none

    init(getMovieByCategoryUseCase: GetMovieByCategoryUseCaseProtocol) {
        self.getMovieByCategoryUseCase = getMovieByCategoryUseCase
    }

    @MainActor
    func fetchMovies(by category: CategoryDomailModel<MovieDomainModel>) async {
        guard let categoryIndex = categories.firstIndex(where: { $0.category == category.category }) else { return }
        categories[categoryIndex].page += 1
        categories[categoryIndex].isPendingRequest = true
        let categoryModel = categories[categoryIndex]
        do {
            let response = try await getMovieByCategoryUseCase.execute(category: categoryModel.category.categoryName,
                                                                       page: categoryModel.page)
            handleSuccess(categoryIndex: categoryIndex, response: response)
        } catch {
            handleError(error: error)
        }
        showSkeleton = false
    }

    @MainActor
    private func handleSuccess(categoryIndex: Int, response: BaseDomailModel<MovieDomainModel>) {
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

extension MovieListViewModel {
    @MainActor
    func fetchAllMovies() async {
        showSkeleton = true
        for category in categories {
            await fetchMovies(by: category)
        }
    }

    func onMoviePressed(_ movie: MovieDomainModel) {
        movieSelected = movie
        showMovieDetailView = true
    }

    @MainActor
    func onPaginateIfNeeded(category: CategoryDomailModel<MovieDomainModel>) async {
        if category.page < category.totalPages {
            await fetchMovies(by: category)
        }
    }
}

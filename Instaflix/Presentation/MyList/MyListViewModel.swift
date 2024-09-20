//
//  MyListViewModel.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 17/09/24.
//

import Combine
import Foundation

@Observable
class MyListViewModel: ObservableObject {
    private let getMyListMovieUseCase: GetMyListMovieUseCaseProtocol
    private let getMyListSerieUseCase: GetMyListSerieUseCaseProtocol
    var movieList: [MovieDomainModel] = []
    var serieList: [SerieDomainModel] = []
    var showSerieDetailView: Bool = false
    var showMovieDetailView: Bool = false
    var movieSelected: MovieDomainModel?
    var serieSelected: SerieDomainModel?
    var showLoading: Bool = false
    var error: NetworkErrorType = .none

    init(getMyListMovieUseCase: GetMyListMovieUseCaseProtocol,
         getMyListSerieUseCase: GetMyListSerieUseCaseProtocol) {
        self.getMyListMovieUseCase = getMyListMovieUseCase
        self.getMyListSerieUseCase = getMyListSerieUseCase
    }

    func fetchAllData() {
        showLoading = true
        fetchMovies()
        fetchSeries()
    }

    func fetchMovies() {
        let response = getMyListMovieUseCase.execute()
        self.movieList = response
        showLoading = false
    }

    func fetchSeries() {
        let response = getMyListSerieUseCase.execute()
        self.serieList = response
        showLoading = false
    }
}

extension MyListViewModel {
    func onMoviePressed(_ item: MovieDomainModel) {
        movieSelected = item
        showMovieDetailView = true
    }

    func onSeriePressed(_ item: SerieDomainModel) {
        serieSelected = item
        showSerieDetailView = true
    }
}


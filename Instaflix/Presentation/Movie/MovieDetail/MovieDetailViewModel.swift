//
//  MovieDetailViewModel.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 13/09/24.
//

import Combine
import Foundation

@Observable
class MovieDetailViewModel: ObservableObject {
    private let getMovieByIdUseCase: GetMovieDetailByIdUseCaseProtocol
    private let getSimilarMoviesByIdUseCase: GetSimilarMoviesByIdUseCaseProtocol
    private let getMovieVideoByIdUseCase: GetVideoByIdUseCaseProtocol
    private let similarPage = 1
    private let similarMoviesToShow = 6
    var currentMovie: (any ItemInformationProtocol)?
    var nextMovie: (any ItemInformationProtocol)?
    var similarList: [MovieDomainModel] = []
    var videoDomainModel: VideoDomainModel?
    var showLoading: Bool = false
    var showSimilarMovieDetailView: Bool = false
    var error: NetworkErrorType = .none

    init(
        getMovieByIdUseCase: GetMovieDetailByIdUseCaseProtocol,
        getSimilarMoviesByIdUseCase: GetSimilarMoviesByIdUseCaseProtocol,
        getMovieVideoByIdUseCase: GetVideoByIdUseCaseProtocol,
        movie: (any ItemInformationProtocol)?
    ) {
        self.getMovieByIdUseCase = getMovieByIdUseCase
        self.getSimilarMoviesByIdUseCase = getSimilarMoviesByIdUseCase
        self.getMovieVideoByIdUseCase = getMovieVideoByIdUseCase
        self.currentMovie = movie
    }

    @MainActor
    func fetchAllInformation(movieId: Int?) async {
        guard let movieId else { return }
        showLoading = true
        do {
            async let movieData = getMovieByIdUseCase.execute(id: movieId)
            async let similarData = getSimilarMoviesByIdUseCase.execute(id: movieId, page: similarPage)
            async let videoData = getMovieVideoByIdUseCase.execute(id: movieId, path: MediaType.serie.enpointValue)
            let (movieResponse, similarResponse, videoResponse) = try await (movieData, similarData, videoData)
            currentMovie = movieResponse
            similarList = Array(similarResponse.results.prefix(similarMoviesToShow))
            videoDomainModel = videoResponse
        } catch {
            handleError(error: error)
        }
        showLoading = false
    }

    @MainActor
    func fetchMovieDetail(_ itemId: Int) async throws {
        do {
            let movie = try await getMovieByIdUseCase.execute(id: itemId)
            currentMovie = movie
            //setAditionalInformation(from: movie)
        } catch {
            handleError(error: error)
        }
        showLoading = false
    }

    @MainActor
    func fetchSimilar(_ movieId: Int) async throws {
        do {
            let response = try await getSimilarMoviesByIdUseCase.execute(id: movieId, page: similarPage)
            similarList = Array(response.results.prefix(similarMoviesToShow))
        } catch {
            handleError(error: error)
        }
        showLoading = false
    }

    @MainActor
    func fetchVideo(_ movieId: Int) async throws {
        do {
            let response = try await getMovieVideoByIdUseCase.execute(id: movieId, path: MediaType.movie.enpointValue)
            videoDomainModel = response
        } catch {
            handleError(error: error)
        }
        showLoading = false
    }

    private func handleError(error: Error) {
        if let error = error as? NetworkErrorType {
            self.error = error
        } else {
            self.error = .unkown(error)
        }
    }

    private func setAditionalInformation(from movie: MovieDetailDomainModel) {
        if currentMovie?.backdropPath == nil {
            currentMovie?.backdropPath = movie.belongsToCollection?.backdropPath
        }
        currentMovie?.isFavorite = movie.isFavorite
    }
}

extension MovieDetailViewModel {
    func onMoviePressed(_ movie: any ItemInformationProtocol) {
        nextMovie = movie
        showSimilarMovieDetailView = true
    }

    func getVideoId() -> String? {
        guard let trailerVideo = videoDomainModel?.results.last(where: { $0.type == .trailer }) else { return nil }
        return trailerVideo.key
    }
}

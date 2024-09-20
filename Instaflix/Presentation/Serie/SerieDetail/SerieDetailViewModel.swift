//
//  SerieDetailViewModel.swift
//  Instaflix
//
//  Created by Ronal Andres Fabra Jimenez on 16/09/24.
//

import Combine
import Foundation

@Observable
class SerieDetailViewModel: ObservableObject {
    private let getSerieByIdUseCase: GetSerieDetailByIdUseCaseProtocol
    private let getSimilarSeriesByIdUseCase: GetSimilarSeriesByIdUseCaseProtocol
    private let getSerieVideoByIdUseCase: GetVideoByIdUseCaseProtocol
    private let similarPage = 1
    private let similarSeriesToShow = 6
    var currentSerie: (any ItemInformationProtocol)?
    var similarList: [SerieDomainModel] = []
    var videoDomainModel: VideoDomainModel?
    var showLoading: Bool = false
    var nextSerie: (any ItemInformationProtocol)?
    var showSimilarSerieDetailView: Bool = false
    var error: NetworkErrorType = .none

    init(
        getSerieByIdUseCase: GetSerieDetailByIdUseCaseProtocol,
        getSimilarSeriesByIdUseCase: GetSimilarSeriesByIdUseCaseProtocol,
        getSerieVideoByIdUseCase: GetVideoByIdUseCaseProtocol,
        serie: (any ItemInformationProtocol)?
    ) {
        self.getSerieByIdUseCase = getSerieByIdUseCase
        self.getSimilarSeriesByIdUseCase = getSimilarSeriesByIdUseCase
        self.getSerieVideoByIdUseCase = getSerieVideoByIdUseCase
        self.currentSerie = serie
    }

    @MainActor
    func fetchAllInformation(serieId: Int?) async {
        guard let serieId else { return }
        showLoading = true
        do {
            async let serieData = getSerieByIdUseCase.execute(id: serieId)
            async let similarData = getSimilarSeriesByIdUseCase.execute(id: serieId, page: similarPage)
            async let videoData = getSerieVideoByIdUseCase.execute(id: serieId, path: MediaType.serie.enpointValue)
            let (serieResponse, similarResponse, videoResponse) = try await (serieData, similarData, videoData)
            currentSerie = serieResponse
            similarList = Array(similarResponse.results.prefix(similarSeriesToShow))
            videoDomainModel = videoResponse
        } catch {
            handleError(error: error)
        }
        showLoading = false
    }

    @MainActor
    func fetchSerieDetail(_ serieId: Int) async throws {
        do {
            let serie = try await getSerieByIdUseCase.execute(id: serieId)
            currentSerie = serie
        } catch {
            handleError(error: error)
        }
        showLoading = false
    }

    @MainActor
    func fetchSimilar(_ serieId: Int) async throws {
        do {
            let response = try await getSimilarSeriesByIdUseCase.execute(id: serieId, page: similarPage)
            similarList = Array(response.results.prefix(similarSeriesToShow))
        } catch {
            handleError(error: error)
        }
        showLoading = false
    }

    @MainActor
    func fetchVideo(_ serieId: Int) async throws {
        do {
            let response = try await getSerieVideoByIdUseCase.execute(id: serieId, path: MediaType.serie.enpointValue)
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
}

extension SerieDetailViewModel {
    func getVideoId() -> String? {
        guard let trailerVideo = videoDomainModel?.results.last(where: { $0.type == .trailer }) else { return nil }
        return trailerVideo.key
    }

    func onSeriePressed(_ serie: any ItemInformationProtocol) {
        nextSerie = serie
        showSimilarSerieDetailView = true
    }
}

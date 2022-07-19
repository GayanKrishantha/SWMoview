// Created on 10/07/2022

import Combine
import PromiseKit
import SwiftUI

class FilmListViewModel: ObservableObject {
    @Published private(set) var isLoading = false
    @Published var alertMessage: AlertMessage?
    @Published private(set) var films: [Film] = []

    private let coordinator: FilmCordinator
    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository, coordinator: FilmCordinator) {
        self.movieRepository = movieRepository
        self.coordinator = coordinator
    }

    func onAppear() {
        if films.isEmpty {
            fetchMovies()
        }
    }

    private func fetchMovies() {
        isLoading = true

        firstly {
            movieRepository.getFilmResponse()
        }
        .done { filmResponse in
            self.films = filmResponse.movies?.sorted(by: { $0.episodeId! < $1.episodeId! }) ?? []
        }
        .ensure { [self] in
            isLoading = false
        }
        .catch { [self] error in
            alertMessage = AlertMessage(error: error)
        }
    }

    func showDeils(film: Film?) {
        if let films = film {
            coordinator.showDetail(film: films)
        }
    }
    
    func searchResults(allFilms: [Film], searchText: String) -> [Film] {
        var films: [Film] = []
        searchText.isEmpty ? (films = allFilms) :
        (films = filterMovies(films: allFilms, searchText: searchText))
        return films
    }

    func filterMovies(films: [Film], searchText: String) -> [Film] {
        films.filter {
            $0.title!.lowercased().contains(searchText.lowercased())
                || $0.director!.lowercased().contains(searchText.lowercased())
                || $0.openingCrawl!.lowercased().contains(searchText.lowercased())
                || $0.producer!.lowercased().contains(searchText.lowercased())
        }
    }
}

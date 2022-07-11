// Created on 10/07/2022

import Foundation

struct FilmResponse {
    let count: Int?
    let movies: [Film]?

    enum CodingKeys: String, CodingKey {
        case count
        case movies = "results"
    }
}

extension FilmResponse {
    init(from dto: FilmResponseDTO) {
        count = dto.count
        movies = dto.movies.map { $0.map(Film.init) } ?? []
    }
}

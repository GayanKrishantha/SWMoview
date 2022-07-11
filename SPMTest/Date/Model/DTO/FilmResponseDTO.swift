// Created on 10/07/2022

import Foundation

struct FilmResponseDTO: Decodable {
    let count: Int?
    let movies: [FilmDTO]?

    enum CodingKeys: String, CodingKey {
        case count
        case movies = "results"
    }
}

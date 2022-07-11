// Created on 10/07/2022

import Foundation

struct Film {
    let title: String?
    let episodeId: Int?
    let openingCrawl: String?
    let director: String?
    let producer: String?
    let releaseDate: String?
    let created: String?
    let edited: String?
    let url: String?
}

extension Film {
    init(from dto: FilmDTO) {
        title = dto.title
        episodeId = dto.episodeId
        openingCrawl = dto.openingCrawl
        director = dto.director
        producer = dto.producer
        releaseDate = dto.releaseDate
        created = dto.created
        edited = dto.edited
        url = dto.url
    }
}

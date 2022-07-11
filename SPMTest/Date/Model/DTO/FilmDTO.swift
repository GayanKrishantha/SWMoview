// Created on 10/07/2022

import Foundation

struct FilmDTO: Decodable {
    let title: String?
    let episodeId: Int?
    let openingCrawl: String?
    let director: String?
    let producer: String?
    let releaseDate: String?
    let created: String?
    let edited: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case title
        case episodeId = "episode_id"
        case openingCrawl = "opening_crawl"
        case director
        case producer
        case releaseDate = "release_date"
        case created
        case edited
        case url
    }
}

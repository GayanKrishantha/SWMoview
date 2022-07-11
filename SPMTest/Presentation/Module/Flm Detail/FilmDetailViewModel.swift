// Created on 10/07/2022

import Combine
import PromiseKit
import SwiftUI

class FilmDetailViewModel: ObservableObject {
    @Published var film: Film?
    @Published var row: [RowContent] = []

    init(film: Film) {
        self.film = film
        self.setUpDetailPageData()
    }
    
    struct RowContent: Hashable {
        let title: String
        let subtitle: String
    }
    
    func setUpDetailPageData() {
        row.append(RowContent(title: L10n.Label.episode,
                              subtitle: "\(Int(self.film?.episodeId ?? 0))"))
        row.append(RowContent(title: L10n.Label.director,
                              subtitle: self.film?.director ?? L10n.Label.notAvailable))
        row.append(RowContent(title: L10n.Label.producer,
                              subtitle: self.film?.producer ?? L10n.Label.notAvailable))
        row.append(RowContent(title: L10n.Label.releaseDate,
                              subtitle: yyyMMdd(date: self.film?.releaseDate ?? "0000-00-00") ))
        row.append(RowContent(title: L10n.Label.createdAt,
                              subtitle: yyyMMddtt(date: self.film?.created ?? "0000-00-00") ))
        row.append(RowContent(title: L10n.Label.editedAt,
                              subtitle: yyyMMddtt(date: self.film?.edited ?? "0000-00-00") ))
        row.append(RowContent(title: L10n.Label.openingCrawl,
                              subtitle: self.film?.openingCrawl ?? L10n.Label.notAvailable))
    }
}


func yyyMMdd(date: String) -> String {
    if let date = date.yyyMMddToDate {
        return date.description(with: .none)
    }
    return L10n.Label.notAvailable
}

func yyyMMddtt(date: String) -> String {
    if let date = date.yyyMMddttToDate {
        return date.description(with: .none)
    }
    return L10n.Label.notAvailable
}

// Created on 10/07/2022

import Foundation

extension Endpoint {
    static func films(_ filmes: Films) -> Endpoint {
        .swApp(path: filmes.path)
    }

    enum Films {
        case all
        case details

        var path: String {
            switch self {
            case .all:
                return "/api/films/"
            case .details:
                return "/api/films/:id/"
            }
        }
    }
}

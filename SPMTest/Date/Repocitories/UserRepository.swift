// Created on 10/07/2022

import Alamofire
import Combine
import Foundation
import PromiseKit

protocol MovieRepository: AnyObject {
    var filmResponse: FilmResponse? { get }
    func getFilmResponse() -> Promise<FilmResponse>
}

final class MovieRepositoryImpl: MovieRepository {
    private let publicNetwork: Network

    init(publicNetwork: Network) {
        self.publicNetwork = publicNetwork
    }

    var filmResponse: FilmResponse?
    @Published private(set) var films: FilmDTO?

    func getFilmResponse() -> Promise<FilmResponse> {
        firstly { () -> Promise<FilmResponseDTO> in
            publicNetwork.request(
                Route(.get, .films(.all))
            )
        }
        .map(FilmResponse.init)
        .recoverAFError()
        .get { film in
            self.filmResponse = film
        }
    }
}

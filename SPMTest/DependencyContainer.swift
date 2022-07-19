// Created on 08/07/2022

import Alamofire
import Foundation
import PromiseKit

final class DependencyContainer {
    private lazy var publicSession = Session(
        eventMonitors: [NetworkMonitor()]
    )

    private lazy var publicNetwork: Network = NetworkManager(
        session: publicSession
    )
    private(set) lazy var movieRepository: MovieRepository = MovieRepositoryImpl(
        publicNetwork: publicNetwork
    )
}

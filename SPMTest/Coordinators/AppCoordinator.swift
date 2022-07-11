// Created on 10/07/2022

import Foundation
import UIKit

protocol AppCoordinator: AnyObject {
    func start()
}

final class AppCoordinatorImpl: AppCoordinator {
    private let dependencyContainer: DependencyContainer
    private unowned let navigationController: SWAPINavigationController

    init(dependencyContainer: DependencyContainer,
         navigationController: SWAPINavigationController) {
        self.dependencyContainer = dependencyContainer
        self.navigationController = navigationController
    }

    func start() {
        let coordinator = FilmCordinatorImpl(navigationController: navigationController)
        let viewModel = FilmListViewModel(
            userRepository: dependencyContainer.userRepository, coordinator: coordinator
        )

        let viewController = FilmListViewController(
            viewModel: viewModel
        )

        navigationController.setViewControllers([viewController], animated: false)
    }
}

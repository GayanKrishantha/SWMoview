// Created on 10/07/2022

import Foundation
import PromiseKit
import SafariServices
import UIKit

protocol FilmCordinator: AnyObject {
    func showDetail(film: Film)
}

final class FilmCordinatorImpl: FilmCordinator {
    private unowned let navigationController: SWAPINavigationController

    init(navigationController: SWAPINavigationController) {
        self.navigationController = navigationController
    }

    func showDetail(film: Film) {
        let viewModel = FilmDetailViewModel(film: film)
        let viewController = FilmDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

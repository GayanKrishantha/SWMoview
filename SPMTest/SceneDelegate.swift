// Created on 08/07/2022

import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private(set) var keyWindow: UIWindow?
    private var modalWindow: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            keyWindow = setupKeyWindow(in: windowScene)
            modalWindow = setupModalWindow(in: windowScene)
        }
    }

    func setupKeyWindow(in scene: UIWindowScene) -> UIWindow {
        let dependencyContainer = DependencyContainer()
        let navigationController = SWAPINavigationController(style: .opaque)

        let window = UIWindow(windowScene: scene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let coordinator = AppCoordinatorImpl(
            dependencyContainer: dependencyContainer,
            navigationController: navigationController
        )
        coordinator.start()

        return window
    }

    func setupModalWindow(in scene: UIWindowScene) -> UIWindow {
        let modalWindow = UIWindow(windowScene: scene)
        modalWindow.isHidden = false
        modalWindow.isUserInteractionEnabled = false

        let modalViewController = UIHostingController(rootView: OverlayContainingView())
        modalViewController.view.backgroundColor = UIColor.clear
        modalWindow.rootViewController = modalViewController

        return modalWindow
    }
}

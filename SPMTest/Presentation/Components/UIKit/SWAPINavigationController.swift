// Created on 09/07/2022

import SnapKit
import SwiftUI
import UIKit

final class SWAPINavigationController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? {
        topViewController
    }

    override var childForStatusBarHidden: UIViewController? {
        topViewController
    }

    convenience init() {
        self.init(style: .opaque)
    }

    init(style: UINavigationBar.Style) {
        super.init(nibName: nil, bundle: nil)

        navigationBar.apply(style: style)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

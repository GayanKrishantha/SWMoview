// Created on 09/07/2022

import UIKit

extension UINavigationBarAppearance {

    private static func baseAppearance(tintColor _: UIColor) -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        return appearance
    }

    static func opaque(backgroundColor: UIColor, tintColor: UIColor) -> UINavigationBarAppearance {
        let appearance = baseAppearance(tintColor: tintColor)
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.shadowImage = nil
        appearance.shadowColor = .clear
        return appearance
    }

    static func transparent(tintColor: UIColor) -> UINavigationBarAppearance {
        let appearance = baseAppearance(tintColor: tintColor)
        appearance.configureWithTransparentBackground()
        return appearance
    }
}

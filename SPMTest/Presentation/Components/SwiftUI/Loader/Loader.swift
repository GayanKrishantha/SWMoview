// Created on 10/07/2022

import Lottie
import SwiftUI

struct Loader: View {
    let style: Style
    let size: Size

    var body: some View {
        LottieAnimation(animation: style.animation, loopMode: .loop)
            .aspectRatio(2.0, contentMode: .fit)
            .frame(height: size.height)
    }
}

extension Loader {
    enum Style {
        case light, dark, green

        var animation: Lottie.Animation? {
            switch self {
            case .light: return .loaderLight
            case .dark: return .loaderDark
            case .green: return .loaderGreen
            }
        }
    }

    enum Size {
        case large
        case regular
        case custom(height: CGFloat)

        var height: CGFloat {
            switch self {
            case .large: return 32
            case .regular: return 20
            case let .custom(height): return height
            }
        }
    }
}

private extension Lottie.Animation {
    // MARK: - Loaders

    /// New colors for the loader can be edited and exported from https://lottiefiles.com/share/juzfdaly
    static var loaderLight: Lottie.Animation? { .named("lottie_loader_light") }
    static var loaderDark: Lottie.Animation? { .named("lottie_loader_dark") }
    static var loaderGreen: Lottie.Animation? { .named("lottie_loader_dark") }
}

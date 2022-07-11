// Created on 09/07/2022

import SwiftUI

extension View {
    func enabled(_ isEnabled: Bool) -> some View {
        disabled(!isEnabled)
            .environment(\.isEnabled, isEnabled)
    }

    @ViewBuilder
    func lineHeight(for fontType: FontType) -> some View {
        lineSpacing(fontType.lineSpacing)
    }
}

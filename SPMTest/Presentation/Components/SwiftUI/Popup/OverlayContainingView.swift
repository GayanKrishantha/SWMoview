// Created on 10/07/2022

import SwiftUI

struct OverlayContainingView: View {
    @ObservedObject private(set) var viewModel = OverlayContainingViewModel()
    @State private var showThing = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle().foregroundColor(!viewModel.isPresented ? .clear : .black.opacity(0.2))
                .animation(.linear, value: viewModel.isPresented)
                .edgesIgnoringSafeArea(.all)

            viewModel.content?
                .id(viewModel.hashedId)
                .transition(.move(edge: .bottom).combined(with: .offset(x: 0, y: 40)))
                .animation(.spring(response: 1.5), value: showThing)
                .zIndex(viewModel.contentIndex)
        }
    }
}

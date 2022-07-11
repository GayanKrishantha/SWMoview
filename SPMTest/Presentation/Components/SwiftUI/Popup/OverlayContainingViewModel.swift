// Created on 10/07/2022

import SwiftUI

class OverlayContainingViewModel: ObservableObject {
    /**
     This prevents the modal from causing issues with the identify of the buttons changing when presenting different modals.
     
     Depending on structural identity (or the same identity) will cause the buttons to animate indepedently.
     */
    @Published private(set) var contentIndex: Double = 1

    @Published private(set) var content: AnyView?
    @Published private(set) var hashedId: Int?

    var isPresented: Bool { hashedId != nil }

    func update<Model: Identifiable, ContentView: View>(
        binding: Binding<Model?>,
        content newContent: ContentView?
    ) {
        guard
            let model = binding.wrappedValue,
            let newContent = newContent
        else {
            content = nil
            hashedId = nil
            return
        }

        content = AnyView(newContent)
        hashedId = model.id.hashValue
        contentIndex += 1
    }
}

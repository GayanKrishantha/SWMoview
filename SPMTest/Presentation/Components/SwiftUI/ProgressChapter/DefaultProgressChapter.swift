// Created on 10/07/2022

import SwiftUI

struct DefaultProgressChapter {
    enum State {
        case notStarted, active, completed
    }

    let name: String
    let customIndexImage: Image?
    let state: State
}

extension DefaultProgressChapter: ProgressChapter {
    var indexImage: Image? {
        if state == .completed {
            return Image.Icons.Arrow.right
        }
        return customIndexImage
    }

    var indexColor: Color {
        switch state {
        case .notStarted: return .neutral30
        case .active: return .neutral40
        case .completed: return .neutral40
        }
    }

    var nameColor: Color {
        switch state {
        case .notStarted: return .neutral30
        case .active: return .neutral70
        case .completed: return .neutral40
        }
    }

    init(
        _ name: String,
        _ customIndexImage: Image? = nil
    ) {
        self.init(
            name: name,
            customIndexImage: customIndexImage,
            state: .notStarted
        )
    }

    var asNotStarted: Self { with(state: .notStarted) }
    var asActive: Self { with(state: .active) }
    var asCompleted: Self { with(state: .completed) }

    private func with(state: State) -> DefaultProgressChapter {
        DefaultProgressChapter(
            name: name,
            customIndexImage: customIndexImage,
            state: state
        )
    }
}

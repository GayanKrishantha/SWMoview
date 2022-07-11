// Created on 10/07/2022

import SwiftUI

extension AlertMessage: Identifiable {
    var id: Int { title.hashValue }
}

struct AlertMessage {
    let title: String
    let message: String
    let primaryButton: Alert.Button
    let secondaryButton: Alert.Button?
}

extension AlertMessage {
    init(title: String, message: String) {
        self.init(
            title: title,
            message: message,
            primaryButton: .default(Text(L10n.Alert.ok)),
            secondaryButton: nil
        )
    }
}

extension AlertMessage {
    init(error: Error) {
        switch error {
        case let error as NetworkError:
            self.init(networkError: error)
        default:
            self.init(
                title: L10n.Error.common,
                message: L10n.Error.somethingWrong
            )
        }
    }
}

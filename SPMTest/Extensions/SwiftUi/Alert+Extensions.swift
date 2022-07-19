// Created on 09/07/2022

import SwiftUI

extension Alert {
    init(with alertMessage: AlertMessage) {
        self.init(
            title: Text(alertMessage.title),
            message: Text(alertMessage.message),
            dismissButton: .default(Text(L10n.Alert.ok))
        )
    }
}

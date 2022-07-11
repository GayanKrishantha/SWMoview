// Created on 10/07/2022

import Foundation

struct ConsoleLogHandler: LogMessageHandler {
    let minLevel: LogLevel

    init(minLevel: LogLevel) {
        self.minLevel = minLevel
    }

    func handle(_ message: LogMessage) {
        #if DEBUG
            guard message.level >= minLevel else { return }
            print(message)
            if let userInfo = message.userInfo {
                prettyPrint(userInfo)
            }
            if let errorInfo = (message.error as NSError?)?.userInfo {
                prettyPrint(errorInfo)
            }
        #endif
    }

    private func prettyPrint(_ dictionary: [String: Any]) {
        guard
            !dictionary.isEmpty,
            let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted),
            let string = String(data: data, encoding: .utf8)
        else { return }

        print(string)
    }
}

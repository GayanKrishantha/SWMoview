// Created on 10/07/2022

import Foundation

class LogProcessor {
    static let shared = LogProcessor()

    private init() {}

    private let loggingQueue = DispatchQueue(
        label: "logger",
        qos: .utility
    )

    private var handlers: [LogMessageHandler] = [
        ConsoleLogHandler(minLevel: .debug)
    ]

    func log(_ message: LogMessage) {
        loggingQueue.async {
            self.handlers.forEach { handler in
                handler.handle(message)
            }
        }
    }

    func register(handler: LogMessageHandler) {
        loggingQueue.sync {
            self.handlers.append(handler)
        }
    }

    func resetHandlers() {
        loggingQueue.sync {
            self.handlers = []
        }
    }
}

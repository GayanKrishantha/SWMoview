// Created on 10/07/2022

import Foundation
import Sentry

struct SentryLogHandler: LogMessageHandler {
    func handle(_ message: LogMessage) {
        if message.level > .debug {
            addBreadcrumb(for: message)
        }
        if message.level == .fatal {
            if let error = message.error {
                SentrySDK.capture(error: error)
            } else {
                captureEvent(for: message)
            }
        }
    }

    private func addBreadcrumb(for message: LogMessage) {
        let crumb = Breadcrumb()
        crumb.level = {
            switch message.level {
            case .debug: return .debug
            case .info: return .info
            case .warning: return .warning
            case .error: return .error
            case .fatal: return .fatal
            }
        }()
        crumb.category = message.category.name
        crumb.message = message.text
        crumb.data = [
            "line": message.line,
            "file": message.file,
            "function": message.function
        ]
        if let userInfo = message.userInfo {
            crumb.data?["userInfo"] = userInfo
        }
        if let errorInfo = (message.error as NSError?)?.userInfo {
            crumb.data?["error"] = errorInfo
        }
        SentrySDK.addBreadcrumb(crumb: crumb)
    }

    private func captureEvent(for message: LogMessage) {
        let event = Event()
        event.level = {
            switch message.level {
            case .error: return .error
            case .fatal: return .fatal
            default: return .none
            }
        }()
        event.message = .init(formatted: message.text)

        event.extra = [
            "line": message.line,
            "file": message.file,
            "function": message.function
        ]
        if let userInfo = message.userInfo {
            event.extra?["userInfo"] = userInfo
        }
        if let errorInfo = (message.error as NSError?)?.userInfo {
            event.extra?["error"] = errorInfo
        }
        SentrySDK.capture(event: event)
    }
}

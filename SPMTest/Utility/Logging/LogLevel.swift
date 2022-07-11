// Created on 10/07/2022

import Foundation

enum LogLevel: Comparable {
    case debug, info, warning, error, fatal
}

extension LogLevel {
    var icon: String {
        switch self {
        case .debug: return "🛠"
        case .info: return "ℹ️"
        case .warning: return "⚠️"
        case .error: return "‼️"
        case .fatal: return "☠️"
        }
    }

    var name: String {
        switch self {
        case .debug: return "DEBUG"
        case .info: return "INFO"
        case .warning: return "WARNING"
        case .error: return "ERROR"
        case .fatal: return "FATAL"
        }
    }
}

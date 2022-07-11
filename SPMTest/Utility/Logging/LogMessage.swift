// Created on 10/07/2022
import Foundation

struct LogMessage {
    let level: LogLevel
    let category: LogCategory
    let error: Error?
    let text: String
    let userInfo: [String: Any]?
    let file: String
    let function: String
    let line: Int

    private init(
        level: LogLevel,
        category: LogCategory,
        error: Error?,
        text: String,
        userInfo: [String: Any]?,
        file: String,
        function: String,
        line: Int
    ) {
        self.level = level
        self.category = category
        self.error = error
        self.text = text
        self.userInfo = userInfo
        self.file = file.split(separator: "/").last.map(String.init) ?? ""
        self.function = function.trimmingCharacters(in: CharacterSet(charactersIn: "()"))
        self.line = line
    }

    init(
        level: LogLevel,
        category: LogCategory,
        text: String,
        userInfo: [String: Any]?,
        file: String,
        function: String,
        line: Int
    ) {
        self.init(
            level: level,
            category: category,
            error: nil,
            text: text,
            userInfo: userInfo,
            file: file,
            function: function,
            line: line
        )
    }

    init(
        level: LogLevel,
        category: LogCategory,
        error: Error,
        userInfo: [String: Any]?,
        file: String,
        function: String,
        line: Int
    ) {
        self.init(
            level: level,
            category: category,
            error: error,
            text: String(describing: error),
            userInfo: userInfo,
            file: file,
            function: function,
            line: line
        )
    }
}

// MARK: Default log message setup

extension LogMessage: CustomStringConvertible {
    var description: String {
        "\(level.icon) [\(category.name)] \(file):\(function)#\(line): \(text)"
    }
}

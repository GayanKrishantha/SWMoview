// Created on 10/07/2022

import Foundation

struct Logger {
    private let category: LogCategory

    init(_ category: LogCategory) {
        self.category = category
    }

    func log(
        _ level: LogLevel,
        _ text: String,
        userInfo: [String: Any]? = nil,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        LogProcessor.shared.log(
            LogMessage(
                level: level,
                category: category,
                text: text,
                userInfo: userInfo,
                file: file,
                function: function,
                line: line
            )
        )
    }

    func log(
        _ level: LogLevel,
        _ error: Error,
        userInfo: [String: Any]? = nil,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        LogProcessor.shared.log(
            LogMessage(
                level: level,
                category: category,
                error: error,
                userInfo: userInfo,
                file: file,
                function: function,
                line: line
            )
        )
    }
}

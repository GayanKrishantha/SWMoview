// Created on 09/07/2022

import Foundation

extension JSONDecoder {
    static let `default`: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)

            if let date = ISO8601DateFormatter.withFractionalSeconds.date(from: string) {
                return date
            }

            if let date = ISO8601DateFormatter.withoutFractionalSeconds.date(from: string) {
                return date
            }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid date: " + string
            )
        }
        return jsonDecoder
    }()
}

private extension ISO8601DateFormatter {
    static let withFractionalSeconds = ISO8601DateFormatter { formatter in
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    }

    static let withoutFractionalSeconds = ISO8601DateFormatter { formatter in
        formatter.formatOptions = [.withInternetDateTime]
    }
}

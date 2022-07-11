// Created on 10/07/2022

import Alamofire
import Foundation

final class NetworkMonitor: EventMonitor {
    func requestDidFinish(_ request: Request) {
        let method = request.request?.method?.rawValue ?? "?"
        let url = request.request?.url?.absoluteString ?? "-"
        let statusCode = request.response.map(\.statusCode).map(String.init) ?? "no code"
        let message = "[\(statusCode)] \(method) \(url)"

        let duration: TimeInterval = request.allMetrics.reduce(0.0) { partialResult, metrics in
            partialResult + metrics.taskInterval.duration
        }

        lazy var durationFormatter = MeasurementFormatter {
            $0.unitStyle = .short
        }

        Logger(.network).log(.info, message, userInfo: [
            "request": [
                "method": method,
                "url": url
            ],
            "response": [
                "statusCode": statusCode
            ],
            "metrics": [
                "duration": durationFormatter.string(
                    from: Measurement(value: duration, unit: UnitDuration.seconds)
                ),
                "retryCount": request.retryCount
            ]
        ])
    }
}

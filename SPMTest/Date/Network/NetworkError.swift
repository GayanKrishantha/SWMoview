// Created on 10/07/2022

import Alamofire
import Foundation

enum NetworkError: Error {
    struct Response: Equatable {
        var statusCode: Int
        var data: Data?
    }

    case clientError(Response)
    case serverError(Response)
    case unauthorized(Data?)
    case forbidden(Data?)
    case timedOut
    case notConnectedToInternet
    case cannotConnectToHost

    static var unauthorized: NetworkError {
        .unauthorized(nil)
    }

    static var forbidden: NetworkError {
        .forbidden(nil)
    }

    init?(_ error: Error, responseData: Data? = nil) {
        switch error {
        case let AFError.responseValidationFailed(.customValidationFailed(networkError as NetworkError)):
            self = networkError

        case let AFError.responseValidationFailed(.unacceptableStatusCode(statusCode)) where statusCode == 401:
            self = .unauthorized(responseData)

        case let AFError.responseValidationFailed(.unacceptableStatusCode(statusCode)) where statusCode == 403:
            self = .forbidden(responseData)

        case let AFError.responseValidationFailed(
            .unacceptableStatusCode(statusCode)) where (400 ... 499).contains(statusCode):
            self = .clientError(Response(
                statusCode: statusCode,
                data: responseData
            ))

        case let AFError.responseValidationFailed(
            .unacceptableStatusCode(statusCode)) where (500 ... 599).contains(statusCode):
            self = .serverError(Response(
                statusCode: statusCode,
                data: responseData
            ))

        case AFError.requestAdaptationFailed(Alamofire.AuthenticationError.missingCredential):
            self = .unauthorized

        case AFError.requestRetryFailed(is Alamofire.AuthenticationError, _):
            self = .unauthorized

        case let AFError.requestAdaptationFailed(networkError as NetworkError),
             AFError.requestRetryFailed(let networkError as NetworkError, _),
             AFError.requestRetryFailed(_, let networkError as NetworkError):
            self = networkError

        case let AFError.sessionTaskFailed(error as NSError) where error.code == NSURLErrorTimedOut:
            self = .timedOut

        case let AFError.sessionTaskFailed(error as NSError) where error.code == NSURLErrorNotConnectedToInternet:
            self = .notConnectedToInternet

        case let AFError.sessionTaskFailed(error as NSError) where error.code == NSURLErrorCannotConnectToHost:
            self = .cannotConnectToHost

        default:
            return nil
        }
    }

    var name: String {
        switch self {
        case let .clientError(response):
            return "clientError (statusCode: \(response.statusCode))"
        case let .serverError(response):
            return "serverError (statusCode: \(response.statusCode))"
        case .unauthorized:
            return "unauthorized"
        case .forbidden:
            return "forbidden"
        case .timedOut:
            return "timedOut"
        case .notConnectedToInternet:
            return "notConnectedToInternet"
        case .cannotConnectToHost:
            return "cannotConnectToHost"
        }
    }

    var data: Data? {
        switch self {
        case let NetworkError.clientError(response),
             let NetworkError.serverError(response):
            return response.data
        case let NetworkError.unauthorized(data), let NetworkError.forbidden(data):
            return data
        default:
            return nil
        }
    }
}

extension NetworkError: CustomNSError {
    static var errorDomain: String {
        "NetworkError"
    }

    var errorUserInfo: [String: Any] {
        switch self {
        case let .clientError(response), let .serverError(response):
            return ["statusCode": response.statusCode]
        default:
            return [:]
        }
    }
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        String(format: "%@.%@", Self.errorDomain, name)
    }
}

extension NetworkError: Equatable {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.unauthorized, .unauthorized),
             (.forbidden, .forbidden),
             (.timedOut, .timedOut),
             (.notConnectedToInternet, .notConnectedToInternet),
             (.cannotConnectToHost, .cannotConnectToHost):
            return true

        case let (.clientError(lhsResponse), .clientError(rhsResponse)),
             let (.serverError(lhsResponse), .serverError(rhsResponse)):
            return lhsResponse == rhsResponse
        default:
            return false
        }
    }
}

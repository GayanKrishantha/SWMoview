// Created on 10/07/2022

import Alamofire
import Foundation
import PromiseKit

final class NetworkManager: Network {
    private let session: Session

    init(session: Session) {
        self.session = session
    }

    // MARK: Request

    func request<Response: Decodable>(
        _ request: URLRequestConvertible,
        decoder: JSONDecoder,
        interceptor: RequestInterceptor?
    ) -> Promise<Response> {
        Promise { seal in
            session
                .request(request, interceptor: interceptor)
                .validate(DataRequest.ValidationResult.init)
                .responseDecodable(of: Response.self, decoder: decoder) { response in
                    switch response.result {
                    case let .success(value):
                        seal.fulfill(value)
                    case let .failure(error):
                        seal.reject(NetworkError(error, responseData: response.data) ?? error)
                    }
                }
        }
    }

    func request(
        _ request: URLRequestConvertible,
        interceptor: RequestInterceptor?
    ) -> Promise<Void> {
        Promise { seal in
            session
                .request(request, interceptor: interceptor)
                .validate(DataRequest.ValidationResult.init)
                .response { response in
                    switch response.result {
                    case .success:
                        seal.fulfill(())
                    case let .failure(error):
                        seal.reject(NetworkError(error, responseData: response.data) ?? error)
                    }
                }
        }
    }

    // MARK: Upload

    func upload<Response>(
        _ multipartFormData: MultipartFormData,
        with request: URLRequestConvertible,
        decoder: JSONDecoder,
        interceptor: RequestInterceptor?
    ) -> Promise<Response> where Response: Decodable {
        Promise { seal in
            session
                .upload(multipartFormData: multipartFormData, with: request, interceptor: interceptor)
                .uploadProgress { progress in
                    print("Upload Progress: \(progress.fractionCompleted)")
                }
                .validate(DataRequest.ValidationResult.init)
                .responseDecodable(of: Response.self, decoder: decoder) { response in
                    switch response.result {
                    case let .success(value):
                        seal.fulfill(value)
                    case let .failure(error):
                        seal.reject(NetworkError(error, responseData: response.data) ?? error)
                    }
                }
        }
    }

    func upload(
        _ multipartFormData: MultipartFormData,
        with request: URLRequestConvertible,
        interceptor: RequestInterceptor?
    ) -> Promise<Void> {
        Promise { seal in
            session
                .upload(multipartFormData: multipartFormData, with: request, interceptor: interceptor)
                .uploadProgress { progress in
                    print("Upload Progress: \(progress.fractionCompleted)")
                }
                .validate(DataRequest.ValidationResult.init)
                .response { response in
                    switch response.result {
                    case .success:
                        seal.fulfill(())
                    case let .failure(error):
                        seal.reject(NetworkError(error, responseData: response.data) ?? error)
                    }
                }
        }
    }
}

private extension DataRequest.ValidationResult {
    // Custom init for ValidationResult to return a custom validation failed result
    // providing the response data for a 401 unauthorized response status code
    init(request _: URLRequest?, response: HTTPURLResponse, data: Data?) {
        switch response.statusCode {
        case 200 ... 299:
            self = .success(())
        case 401:
            self = .failure(AFError.responseValidationFailed(
                reason: .customValidationFailed(
                    error: NetworkError.unauthorized(data)
                )
            ))
        default:
            self = .failure(AFError.responseValidationFailed(
                reason: .unacceptableStatusCode(
                    code: response.statusCode
                )
            ))
        }
    }
}

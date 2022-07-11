// Created on 10/07/2022

import Alamofire
import Foundation
import PromiseKit

protocol Network: AnyObject {
    // MARK: Request

    func request<Response: Decodable>(_ request: URLRequestConvertible,
                                      decoder: JSONDecoder,
                                      interceptor: RequestInterceptor?) -> Promise<Response>

    func request(
        _ request: URLRequestConvertible,
        interceptor: RequestInterceptor?
    ) -> Promise<Void>
}

extension Network {
    // MARK: Request

    func request<Response: Decodable>(_ request: URLRequestConvertible,
                                      decoder: JSONDecoder = .default,
                                      interceptor: RequestInterceptor? = nil) -> Promise<Response> {
        self.request(request, decoder: decoder, interceptor: interceptor)
    }

    func request(_ request: URLRequestConvertible) -> Promise<Void> {
        self.request(request, interceptor: nil)
    }
}

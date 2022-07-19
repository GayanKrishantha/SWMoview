// Created on 10/07/2022

import Alamofire
import Foundation
import UIKit

enum EndpointError: Error {
    case invalidURL
}

struct Endpoint: URLConvertible {
    var baseURL: URL
    var path: String
    var queryItems: [URLQueryItem]?

    static func swApp(path: String, with queryItems: [URLQueryItem]? = nil) -> Endpoint {
        Endpoint(baseURL: .swApp, path: path, queryItems: queryItems)
    }
}

extension Endpoint {
    func asURL() throws -> URL {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        guard let url = components?.url else {
            throw EndpointError.invalidURL
        }
        return url
    }
}

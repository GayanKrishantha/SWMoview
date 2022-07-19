// Created on 09/07/2022

import Foundation
import UIKit

extension URL: Identifiable {
    public var id: String {
        absoluteString
    }

    static var settings: URL {
        URL(string: UIApplication.openSettingsURLString)!
    }

    static var swApp: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Bundle.main.object(forInfoDictionaryKey: "SW_API_HOST") as? String

        return components.url!
    }
}

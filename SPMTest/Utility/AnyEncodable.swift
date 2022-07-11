// Created on 10/07/2022

import Foundation

struct AnyEncodable: Encodable {
    private var encodable: Encodable

    init(_ encodable: Encodable) {
        self.encodable = encodable
    }

    func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}

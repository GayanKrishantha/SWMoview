// Created on 09/07/2022

import Foundation
import PromiseKit

extension DispatchQueue {
    func promise<T>(_ body: @escaping () throws -> T) -> Promise<T> {
        Promise<T> { seal in
            async {
                do {
                    seal.fulfill(try body())
                } catch {
                    seal.reject(error)
                }
            }
        }
    }
}

// Created on 09/07/2022

import Alamofire
import Foundation
import PromiseKit

extension Promise {
    func delay(_ interval: DispatchTimeInterval) -> Promise<T> {
        then { value in
            after(interval).map { value }
        }
    }

    func recoverAFError() -> Promise<T> {
        recover { error -> Promise<T> in
            throw (error as? Alamofire.AFError)?.underlyingError ?? error
        }
    }

    /// Assign value using a `get` and pass on same value down the chain
    func assign<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, T>, on root: Root) -> Promise<T> {
        get {
            root[keyPath: keyPath] = $0
        }
    }
}

extension Promise where T: Collection {
    func firstValue(where predicate: @escaping (T.Iterator.Element) -> Bool) -> Promise<T.Iterator.Element?> {
        map { $0.first(where: predicate) }
    }
}

extension Guarantee {
    func delay(_ interval: DispatchTimeInterval) -> Guarantee<T> {
        then { value in
            after(interval).map { value }
        }
    }
}

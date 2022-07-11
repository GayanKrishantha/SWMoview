// Created on 10/07/2022

import Foundation

protocol Initializable {
    init()
}

protocol Configurable {}

extension Configurable where Self: Initializable, Self: AnyObject {
    init(with configurator: (Self) -> Void) {
        let instance = Self()
        configurator(instance)
        self = instance
    }
}

extension Configurable where Self: Initializable {
    init(with configurator: (inout Self) -> Void) {
        var instance = Self()
        configurator(&instance)
        self = instance
    }
}

extension Configurable where Self: AnyObject {
    @discardableResult
    func configure(with configurator: (Self) -> Void) -> Self {
        configurator(self)
        return self
    }
}

extension Configurable {
    @discardableResult
    mutating func configure(with configurator: (inout Self) -> Void) -> Self {
        configurator(&self)
        return self
    }
}

extension NSObject: Initializable, Configurable {}

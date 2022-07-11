// Created on 09/07/2022

import Combine
import Foundation

extension Publisher where Failure == Never {
    func assignWeak<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Output>,
                                     on root: Root) -> AnyCancellable {
        sink { [weak root] value in
            root?[keyPath: keyPath] = value
        }
    }

    func onCompletion(perform action: @escaping () -> Void) -> AnyCancellable {
        sink(
            receiveCompletion: { _ in
                action()
            },
            receiveValue: { _ in }
        )
    }
}

extension Publisher where Output == Bool {
    /// Will finish after the output becomes false.
    func finishAfterNextFalse() -> AnyPublisher<Output, Failure> {
        finish { $0 }
    }
}

extension Publisher {
    func delayFirst(
        for timeInterval: DispatchTimeInterval,
        with predicate: ((Output) -> Bool)? = nil
    ) -> AnyPublisher<Output, Failure> {
        let first = first().flatMap { element -> AnyPublisher<Output, Failure> in
            if predicate?(element) ?? true {
                return Just<Output>(element)
                    .delay(for: .init(timeInterval), scheduler: DispatchQueue.main)
                    .setFailureType(to: Failure.self)
                    .eraseToAnyPublisher()
            } else {
                return Just<Output>(element)
                    .setFailureType(to: Failure.self)
                    .eraseToAnyPublisher()
            }
        }

        let remainder = dropFirst()

        return Publishers.Concatenate(
            prefix: first,
            suffix: remainder
        )
        .eraseToAnyPublisher()
    }

    func finish(after predicate: @escaping ((Output) -> Bool)) -> AnyPublisher<Output, Failure> {
        let finishingPublisher = CurrentValueSubject<Output?, Failure>(nil)

        return prefix(while: {
            let valid = predicate($0)
            if !valid {
                finishingPublisher.send($0)
            }
            return valid
        })
        .append(finishingPublisher.compactMap { $0 })
        .eraseToAnyPublisher()
    }
}

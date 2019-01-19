//
//  Extension + PromiseKit.swift
//  Olimp
//
//  Created by Artem Balashov on 04/12/2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//

import Foundation
import PromiseKit

func attempt<T>(maximumRetryCount: Int = 3, delayBeforeRetry: DispatchTimeInterval = .seconds(2), _ body: @escaping () -> Promise<T>) -> Promise<T> {
    var attempts = 0
    func attempt() -> Promise<T> {
        attempts += 1
        return body().recover { error -> Promise<T> in
            guard attempts < maximumRetryCount else { throw error }
            return after(delayBeforeRetry).then(on: nil, attempt)
        }
    }
    return attempt()
}

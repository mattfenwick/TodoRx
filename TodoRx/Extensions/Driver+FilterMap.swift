//
//  Driver+FilterMap.swift
//  TodoRx
//
//  Created by Matt Fenwick on 8/5/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation
import RxCocoa

extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {

    func filterMap<T>(f: @escaping (E) -> T?) -> Driver<T> {
        return flatMap { (element) -> Driver<T> in
            if let value = f(element) {
                return .just(value)
            } else {
                return .empty()
            }
        }
    }
}

//
//  Driver+FilterNil.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/21/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation
import RxCocoa

extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy, E: OptionalType {

    func filterNil() -> Driver<E.Wrapped> {
        return flatMap { (element) -> Driver<E.Wrapped> in
            if let value = element.value {
                return .just(value)
            } else {
                return .empty()
            }
        }
    }
}

//
//  Sequence+FilterNil.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/21/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

extension Sequence where Self.Iterator.Element: OptionalType {

    func filterNil() -> [Self.Iterator.Element.Wrapped] {
        return flatMap { $0.value }
    }
    
}

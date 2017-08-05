//
//  Bundle+TodoRx.swift
//  TodoRx
//
//  Created by Matt Fenwick on 8/4/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

extension Bundle {
    static var todoRx: Bundle {
        return Bundle(for: TodoFlowController.self)
    }
}

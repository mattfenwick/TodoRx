//
//  TodoPriority.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/21/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

enum TodoPriority: Int {
    case low = 0
    case medium = 1
    case high = 2

    var todoListSectionType: TodoListSectionType {
        switch self {
        case .low: return .low
        case .medium: return .medium
        case .high: return .high
        }
    }
}

//
//  TodoPriority.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/21/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

enum TodoPriority: AutoEquatable {
    case high
    case medium
    case low

    var todoListSectionType: TodoListSectionType {
        switch self {
        case .high: return .high
        case .medium: return .medium
        case .low: return .low
        }
    }
}

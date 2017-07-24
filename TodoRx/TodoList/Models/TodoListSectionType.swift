//
//  TodoListSectionType.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/19/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

enum TodoListSectionType: Int {
    case high = 0
    case medium = 1
    case low = 2

    var displayText: String {
        switch self {
        case .high: return "High Priority"
        case .medium: return "Medium Priority"
        case .low: return "Low Priority"
        }
    }

}

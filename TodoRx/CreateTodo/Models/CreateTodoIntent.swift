//
//  CreateTodoIntent.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/21/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

struct CreateTodoIntent: AutoEquatable, AutoUpdateValues {
    let name: String
    let priority: TodoPriority

    static let empty = CreateTodoIntent(name: "", priority: .medium)
}

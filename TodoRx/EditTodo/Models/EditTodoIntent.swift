//
//  EditTodoIntent.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/21/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

struct EditTodoIntent: AutoEquatable {
    let id: String
    let name: String
    let priority: TodoPriority
}

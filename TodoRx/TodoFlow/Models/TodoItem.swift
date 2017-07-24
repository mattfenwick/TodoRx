//
//  TodoItem.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/21/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

struct TodoItem: AutoInit, AutoEquatable, AutoUpdateValues {
    let id: String
    let name: String
    let priority: TodoPriority
    let isFinished: Bool

    init(name: String, priority: TodoPriority, isFinished: Bool) {
        self.id = UUID().uuidString
        self.name = name
        self.priority = priority
        self.isFinished = isFinished
    }

    var todoListItem: TodoListItem {
        return TodoListItem(
            id: id,
            name: name,
            type: priority.todoListSectionType,
            isFinished: isFinished)
    }

    var editTodo: EditTodoIntent {
        return EditTodoIntent(id: id, name: name, priority: priority)
    }
}

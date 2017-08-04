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
    let created: Date

    init(name: String, priority: TodoPriority, isFinished: Bool, created: Date) {
        self.id = UUID().uuidString
        self.name = name
        self.priority = priority
        self.isFinished = isFinished
        self.created = created
    }

    var todoListItem: TodoListItem {
        return TodoListItem(
            id: id,
            name: name,
            type: priority.todoListSectionType,
            isFinished: isFinished,
            created: created)
    }

    var editTodo: EditTodoIntent {
        return EditTodoIntent(id: id, name: name, priority: priority)
    }
}

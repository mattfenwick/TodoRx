//
//  EditTodoViewModel.swift
//  TodoRx
//
//  Created by Matt Fenwick on 8/4/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

struct EditTodoViewModel: AutoEquatable, AutoUpdateValues {
    let id: String
    let initialName: String
    let initialPriority: TodoPriority
    let name: String
    let priority: TodoPriority

    var isSaveButtonEnabled: Bool {
        return (initialName != name) || (initialPriority != priority)
    }

    var editTodoIntent: EditTodoIntent {
        return EditTodoIntent(id: id, name: name, priority: priority)
    }

}

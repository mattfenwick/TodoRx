//
//  TodoAction.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/21/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

enum TodoAction: AutoEquatable {
    case fetchLocalTodos
    case saveTodo(TodoItem)
    
    case showCreate
    case hideCreate

    case showEdit(TodoItem?)
    case hideEdit

    case duplicateIdError
    case missingIdError
}

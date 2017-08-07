//
//  TodoCommand.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/21/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

enum TodoCommand: AutoEquatable {
    case initialState

    case fetchSavedTodos
    case didFetchSavedTodos([TodoItem])

    case didCompletePersistenceAction(TodoItemPersistenceResult)
    
    case showCreateView
    case cancelCreate
    case createNewItem(CreateTodoIntent)

    case showUpdateView(id: String)
    case cancelEdit
    case updateItem(EditTodoIntent)

    case toggleItemIsFinished(id: String)
    case deleteItem(id: String)
}

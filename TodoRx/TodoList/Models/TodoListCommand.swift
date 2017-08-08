//
//  TodoListCommand.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/19/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

enum TodoListCommand: AutoEquatable {
    case didTapItem(id: String)
    case didToggleItemDone(id: String)
    case didDeleteItem(id: String)
    case updateItems([TodoListItem])
    case didTapCreateTodo
}

//
//  TodoListAccumulator.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/19/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

func todoListAccumulator(oldModel: TodoListViewModel, command: TodoListCommand) -> (TodoListViewModel, TodoListAction?) {
    print("todo list command: \(command)")

    switch command {
    case let .didTapItem(id):
        return (oldModel, nil) // TODO

    case let .didToggleItemDone(id):
        return (oldModel, nil) // TODO

    case let .updateItems(items):
        return (oldModel.updateValues(items: items), nil)
        
    case .didTapCreateTodo:
        return (oldModel, .showCreate)
    }
}

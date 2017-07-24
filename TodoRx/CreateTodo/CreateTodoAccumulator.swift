//
//  CreateTodoAccumulator.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/22/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

func createTodoAccumulator(old: CreateTodoViewModel, command: CreateTodoCommand) -> (CreateTodoViewModel, CreateTodoAction?) {
    print("create todo command: \(command)")
    
    switch command {
    case let .updateName(name):
        let todo = old.todo.updateValues(name: name)
        return (old.updateValues(todo: todo), nil)

    case let .updatePriority(priority):
        let todo = old.todo.updateValues(priority: priority)
        return (old.updateValues(todo: todo), nil)

    case .didTapSave:
        return (old, .save(old.todo))

    case .didTapCancel:
        return (old, .cancel)
    }
}

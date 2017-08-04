//
//  EditTodoAccumulator.swift
//  TodoRx
//
//  Created by Matt Fenwick on 8/4/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

func editTodoAccumulator(old: EditTodoViewModel, command: EditTodoCommand) -> (EditTodoViewModel, EditTodoAction?) {
    print("edit todo command: \(command)")

    switch command {
    case .initialState:
        return (old, nil)
    case .didTapCancel:
        return (old, .didTapCancel)
    case .didTapSave:
        return (old, .didTapSave(old.editTodoIntent))
    case let .updateName(name):
        return (old.updateValues(name: name), nil)
    case let .updatePriority(priority):
        return (old.updateValues(priority: priority), nil)
    }
}

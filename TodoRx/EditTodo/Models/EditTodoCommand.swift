//
//  EditTodoCommand.swift
//  TodoRx
//
//  Created by Matt Fenwick on 8/4/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

enum EditTodoCommand: AutoEquatable {
    case initialState
    case updateName(String)
    case updatePriority(TodoPriority)
    case didTapCancel
    case didTapSave
}

//
//  CreateTodoCommand.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/22/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

enum CreateTodoCommand: AutoEquatable {
    case updateName(String)
    case updatePriority(TodoPriority)
    case didTapSave
    case didTapCancel
}

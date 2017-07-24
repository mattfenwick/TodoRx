//
//  CreateTodoViewModel.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/22/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

struct CreateTodoViewModel: AutoEquatable, AutoUpdateValues {
    let todo: CreateTodoIntent

    static let empty = CreateTodoViewModel(todo: CreateTodoIntent.empty)
}

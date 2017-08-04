//
//  TodoListItem.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/19/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

struct TodoListItem: AutoEquatable {
    let id: String
    let name: String
    let type: TodoListSectionType
    let isFinished: Bool
    let created: Date

    var rowModel: TodoListRowModel {
        return TodoListRowModel(id: id, name: name, isFinished: isFinished)
    }

}

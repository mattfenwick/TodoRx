//
//  TodoModel.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/21/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

struct TodoModel: AutoEquatable, AutoUpdateValues {
    let itemsDict: [String: TodoItem]

    var items: [TodoItem] { return Array(itemsDict.values) }

    static let empty = TodoModel(itemsDict: ["123": TodoItem(id: "123", name: "medddd", priority: .medium, isFinished: false)])
}

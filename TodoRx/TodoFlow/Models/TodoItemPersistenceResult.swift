//
//  TodoItemSaveResult.swift
//  TodoRx
//
//  Created by Matt Fenwick on 8/5/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

struct TodoItemPersistenceResult: AutoEquatable {
    let itemId: String
    let action: TodoItemPersistenceAction
    let success: Bool
}

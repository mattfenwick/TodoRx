//
//  TodoListAction.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/22/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

enum TodoListAction: AutoEquatable {
    case showCreate
    case showEdit(itemId: String)
    case toggleItemDone(itemId: String)
}

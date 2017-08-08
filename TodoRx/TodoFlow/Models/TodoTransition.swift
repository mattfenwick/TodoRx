//
//  TodoTransition.swift
//  TodoRx
//
//  Created by Matt Fenwick on 8/10/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

enum TodoTransition: AutoEquatable {
    case showCreate
    case hideCreate

    case showEdit(TodoItem)
    case hideEdit
}

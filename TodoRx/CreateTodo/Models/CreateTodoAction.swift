//
//  CreateTodoAction.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/22/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

enum CreateTodoAction: AutoEquatable {
    case save(CreateTodoIntent)
    case cancel
}

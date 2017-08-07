//
//  TodoItemPersistenceResult.swift
//  TodoRx
//
//  Created by Matt Fenwick on 8/7/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

enum TodoItemPersistenceAction: AutoEquatable {
    case save
    case update
    case delete
}

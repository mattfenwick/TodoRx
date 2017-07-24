//
//  TodoListSection.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/19/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

struct TodoListSection: AutoEquatable {
    let sectionType: TodoListSectionType
    let rows: [TodoListRowModel]
}

//
//  TodoListViewModel.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/19/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

struct TodoListViewModel: AutoEquatable {
    let items: [TodoListItem]

    var sections: [TodoListSection] {
        return items.groupElements(projection: { item in item.type })
            .map { tuple in
                TodoListSection(sectionType: tuple.0, rows: tuple.1.map { $0.rowModel })
            }
    }

    var sortedSections: [TodoListSection] {
        // TODO need to start within group by date
        return sections.sorted(by: { lhs, rhs in lhs.sectionType.rawValue < rhs.sectionType.rawValue })
    }

    func updateValues(items: [TodoListItem]? = nil) -> TodoListViewModel {
        return TodoListViewModel(items: items ?? self.items)
    }

    static let empty = TodoListViewModel(items: [])
}

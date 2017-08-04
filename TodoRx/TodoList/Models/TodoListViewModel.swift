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
                // within a group, sort by date
                let rows = tuple.1
                    .sorted(by: { lhs, rhs in lhs.created < rhs.created })
                    .map { $0.rowModel }
                return TodoListSection(sectionType: tuple.0, rows: rows)
            }
    }

    var sortedSections: [TodoListSection] {
        // sort groups by priority
        return sections.sorted(by: { lhs, rhs in lhs.sectionType.rawValue < rhs.sectionType.rawValue })
    }

    func updateValues(items: [TodoListItem]? = nil) -> TodoListViewModel {
        return TodoListViewModel(items: items ?? self.items)
    }

    static let empty = TodoListViewModel(items: [])
}

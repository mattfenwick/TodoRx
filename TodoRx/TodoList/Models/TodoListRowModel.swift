//
//  TodoListRowModel.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/19/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation
import RxDataSources

struct TodoListRowModel: IdentifiableType, Equatable {

    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy:HH-mm"
//        formatter.t
//        formatter.dateStyle = .full
        return formatter
    }()
    
    let id: String
    let name: String
    let created: Date
    let isFinished: Bool
    
    static func == (lhs: TodoListRowModel, rhs: TodoListRowModel) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.created == rhs.created &&
            lhs.isFinished == rhs.isFinished
    }

    var formattedDate: String { return TodoListRowModel.dateFormatter.string(from: created) }

    // MARK: - IdentifiableType

    typealias Identity = String
    var identity: String { return id }
}

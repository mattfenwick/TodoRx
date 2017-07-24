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

    let id: String
    let name: String
    let isFinished: Bool
    
    static func == (lhs: TodoListRowModel, rhs: TodoListRowModel) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.isFinished == rhs.isFinished
    }

    // MARK: - IdentifiableType

    typealias Identity = String
    var identity: String { return id }
}

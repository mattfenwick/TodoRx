//
//  TodoFlowDefaultInteractor.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/19/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

private let dateFormatter = ISO8601DateFormatter()

private extension CDTodo {

    // MARK: - priority

    func setPriority(priority: TodoPriority) {
        self.priority = Int16(priority.rawValue)
    }

    func getPriority() -> TodoPriority {
        return TodoPriority(rawValue: Int(priority))!
    }

    // MARK: - created

    func setCreated(date: Date) {
        created = dateFormatter.string(from: date)
    }

    func getCreated() -> Date {
        // horrible hack to get around NSDate vs. Date issue
        return dateFormatter.date(from: created!)!
    }

}

// MARK: - interactor

class TodoFlowDefaultInteractor: TodoFlowInteractor {

    private let coreDataController: CoreDataController

    init(coreDataController: CoreDataController) {
        self.coreDataController = coreDataController
    }

    func fetchTodos() -> Single<[TodoItem]> {
        return coreDataController.childContext(concurrencyType: .privateQueueConcurrencyType)
            .rx.perform(block: { context in
                let request: NSFetchRequest<CDTodo> = CDTodo.fetchRequest()
                return try context.fetch(request)
                    .map { cdTodo -> TodoItem in
                        TodoItem(
                            id: cdTodo.id!,
                            name: cdTodo.name!,
                            priority: cdTodo.getPriority(),
                            isFinished: cdTodo.isFinished,
                            created: cdTodo.getCreated())
                    }
            })
    }

    func saveTodo(item: TodoItem) -> Single<Void> {
        return coreDataController.childContext(concurrencyType: .privateQueueConcurrencyType)
            .rx.perform(block: { context in
                guard let cdTodo = NSEntityDescription.insertNewObject(forEntityName: "CDTodo", into: context) as? CDTodo else {
                    throw CoreDataError.insertType
                }
                cdTodo.id = item.id
                cdTodo.name = item.name
                cdTodo.setPriority(priority: item.priority)
                cdTodo.setCreated(date: item.created)
                cdTodo.isFinished = item.isFinished
                try context.save()
            })
    }

    func updateTodo(item: TodoItem) -> Single<Void> {
        return coreDataController.childContext(concurrencyType: .privateQueueConcurrencyType)
            .rx.perform(block: { context in
                let request: NSFetchRequest<CDTodo> = CDTodo.fetchRequest()
                request.predicate = NSPredicate(format: "id == %@", item.id)
                let results = try context.fetch(request)
                if let first = results.first {
                    first.isFinished = item.isFinished
                    first.name = item.name
                    first.setPriority(priority: item.priority)
                    try context.save()
                    return
                }
                if results.count != 1 {
                    assert(false, "expected exactly 1 item of id \(item.id), found \(results.count)")
                    throw CoreDataError.invalidItemId(item.id)
                }
            })
    }

    func deleteTodo(itemId: String) -> Single<Void> {
        return coreDataController.childContext(concurrencyType: .privateQueueConcurrencyType)
            .rx.perform(block: { context in
                let request: NSFetchRequest<CDTodo> = CDTodo.fetchRequest()
                request.predicate = NSPredicate(format: "id == %@", itemId)
                let results = try context.fetch(request)
                if let first = results.first {
                    context.delete(first)
                    try context.save()
                    return
                }
                if results.count != 1 {
                    assert(false, "expected exactly 1 item of id \(itemId), found \(results.count)")
                    throw CoreDataError.invalidItemId(itemId)
                }
            })
    }
}

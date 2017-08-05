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

class TodoFlowDefaultInteractor: TodoFlowInteractor {

    private let coreDataController: CoreDataController
    private let dateFormatter = ISO8601DateFormatter()

    init(coreDataController: CoreDataController) {
        self.coreDataController = coreDataController
    }

    func fetchTodos() -> Single<[TodoItem]> {
        return coreDataController.childContext(concurrencyType: .privateQueueConcurrencyType)
            .rx.perform(block: { context in
                let request: NSFetchRequest<CDTodo> = CDTodo.fetchRequest()
                return try context.fetch(request)
                    .map { [unowned self] cdTodo -> TodoItem in
                        TodoItem(
                            id: cdTodo.id!,
                            name: cdTodo.name!,
                            priority: TodoPriority(rawValue: Int(cdTodo.priority))!,
                            isFinished: cdTodo.isFinished,
                            // horrible hack to get around NSDate vs. Date issue
                            created: self.dateFormatter.date(from: cdTodo.created!)!)
                    }
            })
    }

    func saveTodo(item: TodoItem) -> Single<Void> {
        // TODO handle updates
        return coreDataController.childContext(concurrencyType: .privateQueueConcurrencyType)
            .rx.perform(block: { [unowned self] context in
                guard let cdTodo = NSEntityDescription.insertNewObject(forEntityName: "CDTodo", into: context) as? CDTodo else {
                    throw CoreDataError.insertTypeError
                }
                cdTodo.id = item.id
                cdTodo.name = item.name
                cdTodo.priority = Int16(item.priority.rawValue)
                cdTodo.created = self.dateFormatter.string(from: item.created)
                cdTodo.isFinished = item.isFinished
                try context.save()
            })
    }

    func deleteTodo(itemId: String) -> Single<Void> {
        // TODO 
        return Single.just(())
    }
}

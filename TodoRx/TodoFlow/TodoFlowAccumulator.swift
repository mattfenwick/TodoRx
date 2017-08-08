//
//  TodoFlowAccumulator.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/19/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation
import RxSwift

func todoFlowAccumulator(interactor: TodoFlowInteractor) ->
                        (TodoModel, TodoCommand) ->
                        (TodoModel, Observable<TodoCommand>?) {
    return { (old: TodoModel, command: TodoCommand) -> (TodoModel, Observable<TodoCommand>?) in
        print("todo flow command: \(command)")

        switch command {
        case .initialState:
            return (old, nil)

        case .fetchSavedTodos:
            return (old, interactor.fetchTodos().asObservable().map(TodoCommand.didFetchSavedTodos))

        case let .didFetchSavedTodos(todos):
            var newTodos = old.itemsDict
            for todo in todos {
                if let _ = newTodos[todo.id] {
                    assert(false, "unable to insert key \(todo.id), already in dictionary")
                }
                newTodos[todo.id] = todo
            }
            return (old.updateValues(itemsDict: newTodos), nil)

        case .didCompletePersistenceAction:
            return (old, nil)
            
        case .showCreateView:
            assert(old.state == .todoList, "must be in todoList state before showing create view")
            return (old.updateValues(state: .create), nil)

        case .cancelCreate:
            assert(old.state == .create, "must be in todoList state before showing create view")
            return (old.updateValues(state: .todoList), nil)

        case let .createNewItem(item):
            let newItem = TodoItem(name: item.name, priority: item.priority, isFinished: false, created: Date())
            guard old.itemsDict[newItem.id] == nil else {
                assert(false, "duplicate id")
                return (old, nil)
            }
            var newItemsDict = old.itemsDict
            newItemsDict[newItem.id] = newItem
            let save: Observable<TodoCommand> = interactor.saveTodo(item: newItem).asObservable()
                .map { _ in true }
                .catchError { error in
                    assert(false, "unexpected error: \(error)")
                    return Observable.just(false)
                }
                .map { success in
                    TodoCommand.didCompletePersistenceAction(TodoItemPersistenceResult(itemId: newItem.id, action: .save, success: success))
                }
            assert(old.state == .create, "must be in create state before hiding create view")
            return (old.updateValues(itemsDict: newItemsDict, state: .todoList), save)

        case let .showUpdateView(id):
            if let item = old.itemsDict[id] {
                assert(old.state == .todoList, "must be in todoList state before showing edit view")
                return (old.updateValues(state: .edit(item)), nil)
            } else {
                assert(false, "must always find an item to present in update view")
                return (old, nil)
            }

        case .cancelEdit:
            let inEditState: Bool
            switch old.state {
                case .edit: inEditState = true
                default: inEditState = false
            }
            assert(inEditState, "must be in edit state before hiding edit view")
            return (old.updateValues(state: .todoList), nil)

        case let .updateItem(item):
            let inEditState: Bool
            switch old.state {
                case .edit: inEditState = true
                default: inEditState = false
            }
            assert(inEditState, "must be in edit state before hiding edit view")
            if let oldItem = old.itemsDict[item.id] {
                let newItem = oldItem.updateValues(name: item.name, priority: item.priority)
                var newItemsDict = old.itemsDict
                newItemsDict[item.id] = newItem
                let update: Observable<TodoCommand> = interactor.updateTodo(item: newItem).asObservable()
                    .map { _ in true }
                    .catchError { error in
                        assert(false, "unexpected error: \(error)")
                        return Observable.just(false)
                    }
                    .map { success in
                        TodoCommand.didCompletePersistenceAction(TodoItemPersistenceResult(itemId: newItem.id, action: .update, success: success))
                    }
                return (old.updateValues(itemsDict: newItemsDict, state: .todoList), update)
            } else {
                assert(false, "must always find an item to update")
                return (old, nil)
            }

        case let .toggleItemIsFinished(id):
            if let oldItem = old.itemsDict[id] {
                let newItem = oldItem.updateValues(isFinished: !oldItem.isFinished)
                var newItemsDict = old.itemsDict
                newItemsDict[id] = newItem
                let update: Observable<TodoCommand> = interactor.updateTodo(item: newItem).asObservable()
                    .map { _ in true }
                    .catchError { error in
                        assert(false, "unexpected error: \(error)")
                        return Observable.just(false)
                    }
                    .map { success in
                        TodoCommand.didCompletePersistenceAction(TodoItemPersistenceResult(itemId: newItem.id, action: .update, success: success))
                    }
                return (old.updateValues(itemsDict: newItemsDict), update)
            } else {
                assert(false, "must always find an item to update")
                return (old, nil)
            }

        case let .deleteItem(id):
            if let _ = old.itemsDict[id] {
                var newItemsDict = old.itemsDict
                newItemsDict[id] = nil
                let delete: Observable<TodoCommand> = interactor.deleteTodo(itemId: id).asObservable()
                    .map { _ in true }
                    .catchError { error in
                        assert(false, "unexpected error: \(error)")
                        return Observable.just(false)
                    }
                    .map { success in
                        TodoCommand.didCompletePersistenceAction(TodoItemPersistenceResult(itemId: id, action: .delete, success: success))
                    }
                return (old.updateValues(itemsDict: newItemsDict), delete)
            } else {
                assert(false, "must always find an item to delete")
                return (old, nil)
            }
        }
    }
}

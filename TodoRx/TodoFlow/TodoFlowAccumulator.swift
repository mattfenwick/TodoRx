//
//  TodoFlowAccumulator.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/19/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

func todoFlowAccumulator(old: TodoModel, command: TodoCommand) -> (TodoModel, TodoAction?) {
    print("todo flow command: \(command)")

    switch command {
    case .initialState:
        return (old, nil)

    case .fetchSavedTodos:
        return (old, .fetchLocalTodos)

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
        return (old, .showCreate)

    case .cancelCreate:
        return (old, .hideCreate)

    case let .createNewItem(item):
        let newItem = TodoItem(name: item.name, priority: item.priority, isFinished: false, created: Date())
        guard old.itemsDict[newItem.id] == nil else {
            assert(false, "duplicate id")
            return (old, .duplicateIdError)
        }
        var newItemsDict = old.itemsDict
        newItemsDict[newItem.id] = newItem
        return (old.updateValues(itemsDict: newItemsDict), .saveTodo(newItem))

    case let .showUpdateView(id):
        if let item = old.itemsDict[id] {
            return (old, .showEdit(item))
        } else {
            assert(false, "must always find an item to present in update view")
            return (old, .missingIdError)
        }

    case .cancelEdit:
        return (old, .hideEdit)

    case let .updateItem(item):
        if let oldItem = old.itemsDict[item.id] {
            let newItem = oldItem.updateValues(name: item.name, priority: item.priority)
            var newItemsDict = old.itemsDict
            newItemsDict[item.id] = newItem
            // TODO we also need to hide the VC.
            // how do we do that?
            return (old.updateValues(itemsDict: newItemsDict), .updateTodo(newItem))
        } else {
            assert(false, "must always find an item to update")
            return (old, .missingIdError)
        }

    case let .toggleItemIsFinished(id):
        if let oldItem = old.itemsDict[id] {
            let newItem = oldItem.updateValues(isFinished: !oldItem.isFinished)
            var newItemsDict = old.itemsDict
            newItemsDict[id] = newItem
            return (old.updateValues(itemsDict: newItemsDict), .updateTodo(newItem))
        } else {
            assert(false, "must always find an item to update")
            return (old, .missingIdError)
        }

    case let .deleteItem(id):
        if let _ = old.itemsDict[id] {
            var newItemsDict = old.itemsDict
            newItemsDict[id] = nil
            return (old.updateValues(itemsDict: newItemsDict), nil)
        } else {
            assert(false, "must always find an item to delete")
            return (old, .missingIdError)
        }

    }
}

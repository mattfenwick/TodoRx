//
//  TodoFlowPresenter.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/19/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TodoFlowPresenter: TodoListInteractor, CreateTodoInteractor {

    private let todoModel: Driver<TodoModel>
    private let commandSubject = PublishSubject<TodoCommand>()

    init(interactor: TodoFlowInteractor) {

        let commands = commandSubject
            .asDriver { error in
                assert(false, "this should never happen -- \(error)")
                return Driver.empty()
            }
            .startWith(.initialState)

        let todoModelAndActions: Driver<(TodoModel, [TodoAction])> = commands.scan(
            (TodoModel.empty, []),
            accumulator: { old, command in
                todoFlowAccumulator(old: old.0, command: command)
            })

        todoModel = todoModelAndActions.map { tuple in tuple.0 }

        let actions = todoModelAndActions.map { tuple in tuple.1 }

        presentCreateItemView = actions
            .filter { $0.contains(.showCreate) }
            .map { _ in }

        dismissCreateItemView = actions
            .filter { $0.contains(.hideCreate) }
            .map { _ in }

        presentEditItemView = actions
            .map { (actions: [TodoAction]) -> EditTodoIntent? in
                for action in actions {
                    switch action {
                    case let .showEdit(.some(item)): return item.editTodo
                    case .showEdit(.none): break // not sure what to do ... this is just for error-handling
                    default: break // TODO this breaks out of the *switch*, right?  *not* the loop?
                    }
                }
                return nil
            }
            .filterNil()

        dismissEditItemView = actions
            .filter { $0.contains(.hideEdit) }
            .map { _ in }
    }

    // MARK: - for the flow controller

    let presentCreateItemView: Driver<Void>
    let dismissCreateItemView: Driver<Void>

    let presentEditItemView: Driver<EditTodoIntent>
    let dismissEditItemView: Driver<Void>

    // MARK: - EditTodoInteractor

    func editTodoDidTapCancel() {
        commandSubject.onNext(.cancelEdit)
    }

    func editTodoDidTapSave(item: EditTodoIntent) {
        commandSubject.onNext(.updateItem(item))
    }

    // MARK: - CreateTodoInteractor

    func createTodoCancel() {
        commandSubject.onNext(.cancelCreate)
    }

    func createTodoSave(item: CreateTodoIntent) {
        commandSubject.onNext(.createNewItem(item))
    }

    // MARK: - TodoListInteractor

    func todoListDidTapItem(id: String) {
        commandSubject.onNext(.showUpdateView(id: id))
    }

    func todoListShowCreate() {
        commandSubject.onNext(.showCreateView)
    }

    lazy private (set) var todoListItems: Driver<[TodoListItem]> = self.todoModel
        .map { model in model.items.map { $0.todoListItem } }
        .distinctUntilChanged(==)
}

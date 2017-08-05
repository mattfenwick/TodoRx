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

class TodoFlowPresenter:
        TodoListInteractor,
        CreateTodoInteractor,
        EditTodoInteractor {

    private let todoModel: Driver<TodoModel>
    private let commandSubject = PublishSubject<TodoCommand>()
    private let disposeBag = DisposeBag()

    init(interactor: TodoFlowInteractor) {

        let commands = commandSubject
            .asDriver { error in
                assert(false, "this should never happen -- \(error)")
                return Driver.empty()
            }
            .startWith(.initialState)
            .startWith(.fetchSavedTodos)

//        commandSubject.onNext(.initialState)
//        commandSubject.onNext(.fetchSavedTodos)

        let todoModelAndActions: Driver<(TodoModel, TodoAction?)> = commands.scan(
            (TodoModel.empty, nil),
            accumulator: { old, command in
                todoFlowAccumulator(old: old.0, command: command)
            })

        todoModel = todoModelAndActions.map { tuple in tuple.0 }

        let actions: Driver<TodoAction> = todoModelAndActions
            .map { tuple in tuple.1 }
            .filterNil()

        presentCreateItemView = actions
            .filter { $0 == .showCreate }
            .map { _ in }

        dismissCreateItemView = actions
            .filter { action -> Bool in
                switch action {
                case .hideCreate, .saveTodo: return true
                default: return false
                }
            }
            .map { _ in }

        presentEditItemView = actions
            .map { (action: TodoAction) -> EditTodoIntent? in
                switch action {
                case let .showEdit(.some(item)): return item.editTodo
                case .showEdit(.none): return nil // not sure what to do ... this is just for error-handling
                default: return nil
                }
            }
            .filterNil()

        dismissEditItemView = actions
            .filter { $0 == .hideEdit }
            .map { _ in }

        // 2-part actions that need to get something dumped back into the command/scan loop

        actions
            .filter { $0 == .fetchLocalTodos }
            .flatMap { _ in
                interactor.fetchTodos()
                    .asDriver(onErrorRecover: { error in
                        assert(false, "unexpected core data error: \(error)")
                        return Driver.just([])
                    })
            }
            .drive(onNext: { [unowned self] todos in
                self.commandSubject.onNext(.didFetchSavedTodos(todos))
            })
            .disposed(by: disposeBag)

        actions
            .filterMap(f: { action -> TodoItem? in
                switch action {
                case let .saveTodo(todo): return todo
                default: return nil
                }
            })
            .flatMap { todo in
                interactor.saveTodo(item: todo)
                    .map { _ in TodoItemSaveResult(itemId: todo.id, success: true) }
                    .asDriver(onErrorRecover: { error in
                        assert(false, "unexpected core data error: \(error)")
                        return Driver.just(TodoItemSaveResult(itemId: todo.id, success: false))
                    })
            }
            .drive(onNext: { [unowned self] result in
                self.commandSubject.onNext(.didPersistTodo(result))
            })
            .disposed(by: disposeBag)
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

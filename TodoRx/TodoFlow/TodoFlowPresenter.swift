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
    private let accumulator: (TodoModel, TodoCommand) -> (TodoModel, Observable<TodoCommand>?)

    init(interactor: TodoFlowInteractor) {

        let commands = commandSubject
            .asDriver { error in
                assert(false, "this should never happen -- \(error)")
                return Driver.empty()
            }
            .startWith(.initialState)
            .startWith(.fetchSavedTodos)

        let accumulator = todoFlowAccumulator(interactor: interactor)

        let todoOutput: Driver<(TodoModel, Observable<TodoCommand>?)> = commands.scan(
            (TodoModel.empty, nil),
            accumulator: { old, command in
                accumulator(old.0, command)
            })

        self.accumulator = accumulator
        todoModel = todoOutput.map { tuple in tuple.0 }

        let states: Driver<(TodoState, TodoState)> = todoModel
            .map { $0.state }
            .scan((TodoState.todoList, TodoState.todoList),
                  accumulator: { previous, current in (previous.1, current) })

        presentCreateItemView = states
            .map { (pair: (TodoState, TodoState)) -> Void? in
                switch pair {
                case (.todoList, .create): return ()
                default: return nil
                }
            }
            .filterNil()

        dismissCreateItemView = states
            .map { (pair: (TodoState, TodoState)) -> Void? in
                switch pair {
                case (.create, .todoList): return ()
                default: return nil
                }
            }
            .filterNil()

        presentEditItemView = states
            .map { (pair: (TodoState, TodoState)) -> EditTodoIntent? in
                switch pair {
                case let (.todoList, .edit(item)): return item.editTodo
                default: return nil
                }
            }
            .filterNil()

        dismissEditItemView = states
            .map { (pair: (TodoState, TodoState)) -> Void? in
                switch pair {
                case (.edit, .todoList): return ()
                default: return nil
                }
            }
            .filterNil()

        // 2-part actions that need to get something dumped back into the command/scan loop

        let feedback: Driver<Observable<TodoCommand>> = todoOutput
            .map { tuple in tuple.1 }
            .filterNil()

        feedback
            .flatMap {
                $0.asDriver(onErrorRecover: { error in
                    assert(false, "unexpected error: \(error)")
                    return Driver.empty()
                })
            }
            .drive(onNext: commandSubject.onNext)
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

    func todoListToggleItemIsFinished(id: String) {
        commandSubject.onNext(.toggleItemIsFinished(id: id))
    }

    func todoListDeleteItem(id: String) {
        commandSubject.onNext(.deleteItem(id: id))
    }

    lazy private (set) var todoListItems: Driver<[TodoListItem]> = self.todoModel
        .map { model in model.items.map { $0.todoListItem } }
        .distinctUntilChanged(==)
}

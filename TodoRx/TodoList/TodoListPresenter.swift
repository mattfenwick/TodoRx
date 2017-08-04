//
//  TodoListPresenter.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/19/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol TodoListPresenterProtocol {
    var todoItems: Driver<[TodoListSection]> { get }
}

class TodoListPresenter: TodoListPresenterProtocol {

    let todoItems: Driver<[TodoListSection]>

    private let disposeBag = DisposeBag()

    init(interactor: TodoListInteractor,
         didTapCreateTodo: Observable<Void>,
         didTapRow: Observable<String>) {
        let commands: Driver<TodoListCommand> = Observable<Observable<TodoListCommand>>.of(
                didTapCreateTodo.map { _ in TodoListCommand.didTapCreateTodo },
                didTapRow.map(TodoListCommand.didTapItem),
//                didToggleItemDone.map(TodoListCommand.didToggleItemDone), // TODO
                interactor.todoListItems.map(TodoListCommand.updateItems).asObservable()
            )
            .merge()
            .asDriver { error -> Driver<TodoListCommand> in
                fatalError("oops, this really shouldn't have ever happened -- \(error)")
            }

        let modelAndActions = commands.scan(
            (TodoListViewModel.empty, nil),
            accumulator: { previous, command in
                todoListAccumulator(oldModel: previous.0, command: command)
            })

        let viewModel = modelAndActions
            .map { $0.0 }

        todoItems = viewModel
            .map { model in
                model.sortedSections
            }

        let actions = modelAndActions
            .map { $0.1 }

        actions
            .drive(onNext: { action in
                switch action {
                case .none: break
                case .some(.showCreate): interactor.todoListShowCreate()
                case let .some(.showEdit(id)): interactor.todoListDidTapItem(id: id)
                case let .some(.toggleItemDone(id)): break // TODO
                }
            })
            .disposed(by: disposeBag)
    }
}

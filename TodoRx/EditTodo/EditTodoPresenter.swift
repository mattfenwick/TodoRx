//
//  EditTodoPresenter.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/22/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class EditTodoPresenter: CreateTodoPresenterProtocol {
    private let disposeBag = DisposeBag()

    let initialName: String
    let initialPriority: TodoPriority
    let isSaveButtonEnabled: Driver<Bool>
    let title = "Edit TODO"

    init(item: EditTodoIntent,
         interactor: EditTodoInteractor,
         name: Observable<String>,
         priority: Observable<TodoPriority>,
         didTapSave: Observable<Void>,
         didTapCancel: Observable<Void>) {
        self.initialName = item.name
        self.initialPriority = item.priority

        let commands: Driver<EditTodoCommand> = Observable.of(
                name.map(EditTodoCommand.updateName),
                priority.map(EditTodoCommand.updatePriority),
                didTapSave.map { _ in .didTapSave },
                didTapCancel.map { _ in .didTapCancel }
            )
            .merge()
            .startWith(.initialState)
            .asDriver { error in
                fatalError("unexpected error: \(error)")
            }

        let initialViewModel = EditTodoViewModel(
            id: item.id,
            initialName: item.name,
            initialPriority: item.priority,
            name: item.name,
            priority: item.priority)

        let modelAndActions: Driver<(EditTodoViewModel, EditTodoAction?)> = commands.scan(
            (initialViewModel, nil),
            accumulator: { previous, command in
                editTodoAccumulator(old: previous.0, command: command)
            })

        let model = modelAndActions.map { $0.0 }

        isSaveButtonEnabled = model
            .map { $0.isSaveButtonEnabled }
            .distinctUntilChanged()

        let actions = modelAndActions.map { $0.1 }

        actions
            .filterNil()
            .drive(onNext: { action in
                switch action {
                case .didTapCancel: interactor.editTodoDidTapCancel()
                case let .didTapSave(item): interactor.editTodoDidTapSave(item: item)
                }
            })
            .disposed(by: disposeBag)
    }
}

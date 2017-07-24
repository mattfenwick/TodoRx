//
//  CreateTodoPresenter.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/22/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol CreateTodoPresenterProtocol {

}

class CreateTodoPresenter: CreateTodoPresenterProtocol {

    private let disposeBag = DisposeBag()

    init(interactor: CreateTodoInteractor,
         name: Observable<String>,
         priority: Observable<TodoPriority>,
         didTapSave: Observable<Void>,
         didTapCancel: Observable<Void>) {

        let commands: Driver<CreateTodoCommand> = Observable.of(
                name.map(CreateTodoCommand.updateName),
                priority.map(CreateTodoCommand.updatePriority),
                didTapSave.map { _ in CreateTodoCommand.didTapSave },
                didTapCancel.map { _ in CreateTodoCommand.didTapCancel }
            )
            .merge()
            .asDriver { error in
                fatalError("unexpected error: \(error)")
            }

        let modelAndActions = commands.scan(
            (CreateTodoViewModel.empty, nil),
            accumulator: { previous, command in
                createTodoAccumulator(old: previous.0, command: command)
            })

        let actions = modelAndActions
            .map { $0.1 }

        actions
            .drive(onNext: { action in
                switch action {
                case .none: break
                case let .some(.save(todo)): interactor.createTodoSave(item: todo)
                case .some(.cancel): interactor.createTodoCancel()
                }
            })
            .disposed(by: disposeBag)
    }
}

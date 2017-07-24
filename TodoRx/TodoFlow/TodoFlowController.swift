//
//  TodoFlowController.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/19/17.
//  Copyright © 2017 mf. All rights reserved.
//

import UIKit
import RxSwift

class TodoFlowController {

    let viewController: UIViewController

    private let flowPresenter: TodoFlowPresenter

    private let todoListCoordinator: TodoListCoordinator

    private var createTodoCoordinator: CreateTodoCoordinator?
    private var editTodoCoordinator: EditTodoCoordinator?

    private let disposeBag = DisposeBag()

    init(interactor: TodoFlowInteractor) {
        flowPresenter = TodoFlowPresenter(interactor: interactor)
        todoListCoordinator = TodoListCoordinator(interactor: flowPresenter)
        viewController = todoListCoordinator.viewController

        flowPresenter.presentCreateItemView
            .drive(onNext: { [unowned self] in
                self.showCreateView()
            })
            .disposed(by: disposeBag)

        flowPresenter.dismissCreateItemView
            .drive(onNext: { [unowned self] in
                self.hideCreateView()
            })
            .disposed(by: disposeBag)

        // TODO listen to more actions
    }

    // MARK: - actions

    private func showCreateView() {
        let coordinator = CreateTodoCoordinator(interactor: flowPresenter)
        let navController = UINavigationController(rootViewController: coordinator.viewController)
        viewController.present(navController, animated: true, completion: nil)
        self.createTodoCoordinator = coordinator
    }

    private func hideCreateView() {
        viewController.dismiss(animated: true, completion: nil)
        createTodoCoordinator = nil
    }

    private func showEditView(item: EditTodoIntent) {

    }

    private func hideEditView() {

    }
    
}

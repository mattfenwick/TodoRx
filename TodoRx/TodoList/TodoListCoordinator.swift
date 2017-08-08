//
//  TodoListCoordinator.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/19/17.
//  Copyright © 2017 mf. All rights reserved.
//

import UIKit

class TodoListCoordinator {

    let viewController: UIViewController

    init(interactor: TodoListInteractor) {
        let viewController = TodoListViewController()

        let presenter = TodoListPresenter(
            interactor: interactor,
            didTapCreateTodo: viewController.didTapCreateTodo,
            didTapRow: viewController.didTapRow,
            didToggleItemIsFinished: viewController.didToggleItemIsFinished,
            didDeleteItem: viewController.didDeleteItem)
        viewController.presenter = presenter

        self.viewController = viewController
    }
}

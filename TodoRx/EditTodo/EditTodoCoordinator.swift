//
//  EditTodoCoordinator.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/21/17.
//  Copyright © 2017 mf. All rights reserved.
//

import UIKit

class EditTodoCoordinator {

    let viewController: UIViewController

    init(item: EditTodoIntent,
         interactor: EditTodoInteractor) {
        let vc = CreateTodoViewController()
        let presenter = EditTodoPresenter(
            item: item,
            interactor: interactor,
            name: vc.name,
            priority: vc.priority,
            didTapSave: vc.didTapSave,
            didTapCancel: vc.didTapCancel)
        vc.presenter = presenter

        viewController = vc
    }
}

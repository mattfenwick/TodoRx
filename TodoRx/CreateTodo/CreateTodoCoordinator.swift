//
//  CreateTodoCoordinator.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/21/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

class CreateTodoCoordinator {

    let viewController: UIViewController

    init(interactor: CreateTodoInteractor) {
        let vc = CreateTodoViewController()
        let presenter = CreateTodoPresenter(
            interactor: interactor,
            name: vc.name,
            priority: vc.priority,
            didTapSave: vc.didTapSave,
            didTapCancel: vc.didTapCancel)
        vc.presenter = presenter
        self.viewController = vc
    }
}

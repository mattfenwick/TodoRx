//
//  TodoListInteractor.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/19/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation
import RxCocoa

protocol TodoListInteractor {
    func todoListDidTapItem(id: String)
    func todoListShowCreate()
//    func todoListToggleItemIsFinished(id: String) // how to prevent this from causing a data update which
    // causes a UI update ... when the UI has already been updated

    var todoListItems: Driver<[TodoListItem]> { get }
}

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

    var todoListItems: Driver<[TodoListItem]> { get }
}

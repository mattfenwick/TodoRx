//
//  TodoFlowInteractor.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/19/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation
import RxSwift

protocol TodoFlowInteractor {
    func fetchTodos() -> Single<[TodoItem]>
    func saveTodo(item: TodoItem) -> Single<Void>
    func deleteTodo(itemId: String) -> Single<Void>
}

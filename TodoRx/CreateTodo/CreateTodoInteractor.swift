//
//  CreateTodoInteractor.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/22/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

protocol CreateTodoInteractor {
    func createTodoSave(item: CreateTodoIntent)
    func createTodoCancel()
}

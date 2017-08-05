//
//  EditTodoInteractor.swift
//  TodoRx
//
//  Created by Matt Fenwick on 8/4/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

protocol EditTodoInteractor {
    func editTodoDidTapCancel()
    func editTodoDidTapSave(item: EditTodoIntent)
}

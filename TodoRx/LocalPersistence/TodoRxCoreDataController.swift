//
//  TodoRxCoreDataController.swift
//  TodoRx
//
//  Created by Matt Fenwick on 8/4/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

extension CoreDataController {

    static func todoRxCoreDataController() throws -> CoreDataController {
        let documentsDirectory = try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true)
        let storeURL = documentsDirectory.appendingPathComponent("TodoRx.sqlite")
        let bundle = Bundle.todoRx
        guard let modelURL = bundle.url(forResource: "TodoRx", withExtension: "momd") else {
            throw CoreDataError.unableToObtainModelUrlError
        }
        return try CoreDataController.createCoreDataController(storeURL: storeURL, modelURL: modelURL)
    }

}

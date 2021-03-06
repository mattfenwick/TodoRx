//
//  CoreDataError.swift
//  TodoRx
//
//  Created by Matt Fenwick on 8/4/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

enum CoreDataError: Error {
    case insertType
    case unableToObtainModelUrl
    case invalidItemId(String)
}

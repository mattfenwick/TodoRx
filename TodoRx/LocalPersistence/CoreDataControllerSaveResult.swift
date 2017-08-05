//
//  CoreDataControllerSaveResult.swift
//  TodoRx
//
//  Created by Matt Fenwick on 8/4/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

enum CoreDataControllerSaveResult {
    case success
    case backgroundTaskDidExpire
    case saveException(NSError)
}

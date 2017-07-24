//
//  Sequence+Group.swift
//  TodoRx
//
//  Created by Matt Fenwick on 7/19/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation

extension Sequence {
    func groupElements<K: Hashable>(projection: (Iterator.Element) -> K) -> [K: [Iterator.Element]] {
        let emptyDict: [K: [Iterator.Element]] = [K: Array<Iterator.Element>]()
        return self.reduce(emptyDict, { (dict, e) in
            var newDict = dict
            let key = projection(e)
            var group: [Iterator.Element] = newDict[key] ?? Array<Iterator.Element>()
            group.append(e)
            newDict[key] = group
            return newDict
        })
    }
}

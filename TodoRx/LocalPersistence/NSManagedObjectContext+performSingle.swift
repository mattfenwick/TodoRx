//
//  NSManagedObjectContext+performSingle.swift
//  TodoRx
//
//  Created by Matt Fenwick on 8/5/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

public extension Reactive where Base : NSManagedObjectContext {

    public func perform<T>(block: @escaping (NSManagedObjectContext) throws -> T) -> Single<T> {
        return Observable
            .create { observer in
                self.base.perform {
                    do {
                        observer.onNext(try block(self.base))
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                }
                return Disposables.create()
            }
            .asSingle()
    }

}

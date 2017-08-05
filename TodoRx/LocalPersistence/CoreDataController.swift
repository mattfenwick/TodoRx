//
//  CoreDataController.swift
//  TodoRx
//
//  Created by Matt Fenwick on 8/4/17.
//  Copyright © 2017 mf. All rights reserved.
//

import Foundation
import CoreData
import UIKit

private let kMocIdentifier: NSString = "moc identifier"

protocol CoreDataControllerDelegate: class {
    func coreDataControllerDidSave(controller: CoreDataController, result: CoreDataControllerSaveResult)
}

@objc class CoreDataController: NSObject {

    static func createCoreDataController(storeURL: URL, modelURL: URL) throws -> CoreDataController {
        let storeType = NSSQLiteStoreType
        let storeOptions = [
            NSMigratePersistentStoresAutomaticallyOption: true,
            NSInferMappingModelAutomaticallyOption: true
        ]

        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            throw CoreDataInitializationError.unableToInitializeModel
        }

        let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        do {
            try psc.addPersistentStore(ofType: storeType, configurationName: nil, at: storeURL, options: storeOptions)
        } catch let e as NSError {
            throw CoreDataInitializationError.unableToAddPersistentStore(e)
        }
        return CoreDataController(persistentStoreCoordinator: psc)
    }

    weak var delegate: CoreDataControllerDelegate? = nil

    let uiContext: NSManagedObjectContext

    func childContext(concurrencyType: NSManagedObjectContextConcurrencyType) -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: concurrencyType)
        context.parent = masterContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context.performAndWait {
            context.userInfo.setObject("child context", forKey: kMocIdentifier)
        }
        return context
    }

    private let masterContext: NSManagedObjectContext

    private init(persistentStoreCoordinator: NSPersistentStoreCoordinator) {
        masterContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        masterContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        masterContext.persistentStoreCoordinator = persistentStoreCoordinator
        masterContext.userInfo.setObject("master context", forKey: kMocIdentifier)

        uiContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        uiContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        uiContext.parent = masterContext
        uiContext.userInfo.setObject("main queue context", forKey: kMocIdentifier)

        super.init()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleMasterContextObjectsDidChangeNotification(notification:)),
            name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
            object: masterContext)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleMasterContextDidSaveNotification(notification:)),
            name: NSNotification.Name.NSManagedObjectContextDidSave,
            object: masterContext)

        let application = UIApplication.shared
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleDidEnterBackgroundNotification(notification:)),
            name: NSNotification.Name.UIApplicationDidEnterBackground,
            object: application)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func handleMasterContextObjectsDidChangeNotification(notification: Notification) {
        if let context = notification.object as? NSManagedObjectContext,
            context == masterContext {
            saveMasterContext()
        }
    }

    @objc private func handleMasterContextDidSaveNotification(notification: Notification) {
        if let context = notification.object as? NSManagedObjectContext,
            context == masterContext {
            uiContext.perform {
                self.uiContext.mergeChanges(fromContextDidSave: notification)
            }
        }
    }

    @objc private func handleDidEnterBackgroundNotification(notification: Notification) {
        saveMasterContext()
    }

    private func saveMasterContext() {
        let identifier = UIApplication.shared.beginBackgroundTask(withName: "background-moc-save") {
            self.delegate?.coreDataControllerDidSave(controller: self, result: .backgroundTaskDidExpire)
        }

        masterContext.perform {
            do {
                try self.masterContext.save()
                self.delegate?.coreDataControllerDidSave(controller: self, result: .success)
            } catch let error as NSError {
                self.delegate?.coreDataControllerDidSave(controller: self, result: .saveException(error))
            }
            UIApplication.shared.endBackgroundTask(identifier)
        }
    }
    
}

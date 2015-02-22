//
//  CDManager.swift
//  HitList
//
//  Created by Joshua Adams on 2/22/15.
//  Copyright (c) 2015 Josh Adams. All rights reserved.

import Foundation
import CoreData

class CDManager {
    var context : NSManagedObjectContext!
    
    class var sharedCDManager: CDManager {
        struct Static {
            static var instance: CDManager?
            static var token: dispatch_once_t = 0
        }
    
        dispatch_once(&Static.token) {
            Static.instance = CDManager()
        }
    
        return Static.instance!
    }
    
    init() {
        let modelURL = NSBundle.mainBundle().URLForResource("HitList", withExtension: "momd")
        let managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL!)
        let storeURL : NSURL = applicationDocumentsDirectory().URLByAppendingPathComponent("HitList.sqlite")
        var coordinator : NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel!)
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil, error: &error) == nil {
            coordinator = nil
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort() // not for shipping app
        }
        context = NSManagedObjectContext()
        context.persistentStoreCoordinator = coordinator
    }
    
    func applicationDocumentsDirectory() -> NSURL {
        return NSURL(fileURLWithPath: NSHomeDirectory() + "/Documents/")!
    }
}
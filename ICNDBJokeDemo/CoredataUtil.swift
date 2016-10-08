//
//  CoredataUtil.swift
//  ICNDBJokeDemo
//
//  Created by liuzhihui on 16/10/4.
//  Copyright © 2016年 liuzhihui. All rights reserved.
//

import Foundation
import CoreData

class CoredataUtil: NSObject {
    
    static let sharedInstance = CoredataUtil()
    
    private override init() {
        
    }
    
    // MARK: - スタック
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.sonydna.glastonbury.QrioSmartLock" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "ICNDBJoke", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("ICNDBJoke.sqlite")
        let options = [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true ]
        do {
            try coordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch let error as NSError {
            // Report any error we got.
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    
    func insertJoke(joke: Joke) {
        let context = CoredataUtil.sharedInstance.managedObjectContext
        if let entityDescription = NSEntityDescription.entity(forEntityName: "FunnyJoke", in: context!) {
            let newData = FunnyJoke(entity: entityDescription, insertInto: context)
            newData.jokeContent = joke.jokeContent
            newData.updateDate = joke.updateDate
            context?.perform {
                do {
                    try context?.save()
                } catch _ as NSError {
                    
                }
            }
        }
    }
    
}

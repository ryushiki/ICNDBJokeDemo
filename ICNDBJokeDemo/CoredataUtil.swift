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
    
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "ICNDBJokeDemo", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("ICNDBJokeDemo.sqlite")
        let options = [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true ]
        do {
            try coordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch let error as NSError {
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
    }()
    
    lazy var mainContext: NSManagedObjectContext? = {
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    
    func insertJoke(joke: Joke) {
        let newJoke = NSEntityDescription.insertNewObject(forEntityName: "FunnyJoke", into: self.mainContext!)
        newJoke.setValue(joke.jokeContent, forKey: "jokeContent")
        newJoke.setValue(joke.updateDate, forKey: "updateDate")
        
        self.mainContext!.perform({
            do {
                try self.mainContext!.save()
            } catch  {
                fatalError("Failure to save context: \(error)")
            }
        })
        
    }
    
}

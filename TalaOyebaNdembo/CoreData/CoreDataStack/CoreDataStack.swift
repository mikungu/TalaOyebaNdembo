//
//  CoreDataStack.swift
//  TalaOyebaNdembo
//
//  Created by Mikungu Giresse on 14/06/23.
//

import Foundation
import CoreData
import UIKit

class CoreDataStack {
    static let sharedInstance = CoreDataStack()
    
    // MARK: -Core Data Stack
    var coreData = "LeagueCoreData"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: coreData)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

class FarouriteTeamCoreDataStack {
    static let sharedInstance = FarouriteTeamCoreDataStack()
    
    // MARK: -Core Data Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TeamCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

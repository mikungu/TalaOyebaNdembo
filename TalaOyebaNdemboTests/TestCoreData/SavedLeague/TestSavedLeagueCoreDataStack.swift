//
//  TestSavedLeagueCoreDataStack.swift
//  TalaOyebaNdemboTests
//
//  Created by Mikungu Giresse on 14/06/23.
//

import Foundation
import CoreData

@testable import TalaOyebaNdembo

class TestSavedLeagueCoreDataStack {
    static let modelName = "LeagueCoreData"
    static let model: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var testContainer : NSPersistentContainer = {
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType

        let container = NSPersistentContainer(name: TestSavedLeagueCoreDataStack.modelName, managedObjectModel: TestSavedLeagueCoreDataStack.model)

        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    static var testContainer: NSPersistentContainer {
        return TestSavedLeagueCoreDataStack().testContainer
    }

    static var testContext : NSManagedObjectContext {
        return testContainer.viewContext
    }

}

//
//  TestFavouriteTeamCoreData.swift
//  TalaOyebaNdemboTests
//
//  Created by Mikungu Giresse on 14/06/23.
//

import Foundation
import CoreData
@testable import TalaOyebaNdembo

class TestFavouriteTeamCoreDataStack {
    // MARK: -Core Data Stack
    
    static let modelName = "TeamCoreData"
    static let model: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var testContainer : NSPersistentContainer = {
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType

        let container = NSPersistentContainer(name: TestFavouriteTeamCoreDataStack.modelName, managedObjectModel: TestFavouriteTeamCoreDataStack.model)

        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    static var testContainer: NSPersistentContainer {
        return TestFavouriteTeamCoreDataStack().testContainer
    }

    static var testContext : NSManagedObjectContext {
        return testContainer.viewContext
    }
}


//
//  CoreDataGenericService.swift
//  TalaOyebaNdembo
//
//  Created by Mikungu Giresse on 14/06/23.
//

import Foundation
import CoreData

import UIKit

class CoreDataGenericService<T: NSManagedObject> {
    
    let contextService: NSManagedObjectContext
    
    public init(context: NSManagedObjectContext) {
        self.contextService = context
    }
    
    
    // create Object
    func createObject () -> T {
        return T(context: contextService)
    }
    // get Object
    func getObject () -> [T]{
        let request = T.fetchRequest()
        do {
            let results = try contextService.fetch(request)
            return results as! [T]
        } catch let error {
            print ("Error fetching objects: \(error)")
            return []
        }
    }
    //check object
    func checkObject (objectName: String, predicate : NSPredicate?) -> [T] {
        let request = T.fetchRequest()
        request.predicate = predicate
        //NSPredicate(format:"strTeam = %@", recipeName)
        do {
            let results = try contextService.fetch(request)
            return results as! [T]
        } catch let error {
            print ("Error fetching objects: \(error)")
            return []
        }
        
    }
    //save object
    func save () {
        do {
            try contextService.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //delete object
    func deleteObject(objectName: String?, predicate: NSPredicate?) {
        let request = T.fetchRequest()
        request.predicate = predicate
        //NSPredicate (format: "strTeam = %@", recipeName)
        do {
            let objects = try contextService.fetch(request)
            for objectToDelete in objects {
                contextService.delete(objectToDelete as! NSManagedObject)
            }
        } catch let error {
            print ("Error fetching objects: \(error)")
        }
        save()
    }
}

//
//  LeagueSavedModel.swift
//  TalaOyebaNdembo
//
//  Created by Mikungu Giresse on 14/06/23.
//

import Foundation
import CoreData
import UIKit

class LeagueSavedModel {
    
    let coreDataGenericService : CoreDataGenericService<League>
    
    init(coreDataGenericService: CoreDataGenericService<League> = CoreDataGenericService(context: CoreDataStack.sharedInstance.persistentContainer.viewContext)) {
        self.coreDataGenericService = coreDataGenericService
    }
    
    
    func saveLeague (named name: String, completion: @escaping ([League]) -> Void) {
        let league = coreDataGenericService.createObject()
        league.name = name
        coreDataGenericService.save()
        completion ([league])
    }
    
    func getLeague (completion: @escaping ([League]) -> Void) {
        let leagues = coreDataGenericService.getObject()
        completion (leagues)
        
    }
    
    func deleteLeague (completion: @escaping ([League]) -> Void) {
        let leagueName = String ()
        let predicate = NSPredicate(format: "name=%@", leagueName)
        coreDataGenericService.deleteObject(objectName: leagueName, predicate: predicate)
    }
}

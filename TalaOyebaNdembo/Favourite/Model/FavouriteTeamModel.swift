//
//  FavouriteTeamModel.swift
//  TalaOyebaNdembo
//
//  Created by Mikungu Giresse on 14/06/23.
//

import Foundation
import CoreData

class FavouriteTeamModel {
    
    let coreDataGenericService : CoreDataGenericService<TeamEntity>
    
    init(coreDataGenericService: CoreDataGenericService<TeamEntity> = CoreDataGenericService(context: FarouriteTeamCoreDataStack.sharedInstance.persistentContainer.viewContext)) {
        self.coreDataGenericService = coreDataGenericService
    }
    
    func fetchFavorites(completion: @escaping ([Teams]) -> Void) {
        let result = coreDataGenericService.getObject()
        var favoriteTeams: [Teams] = []
        for favorite in result {
            guard let strTeam = favorite.value(forKey: "strTeam") as? String else { return }
            guard let strLeague = favorite.value(forKey: "strLeague") as? String else { return }
            guard let strWebsite = favorite.value(forKey: "strWebsite") as? String else { return }
            guard let strDescriptionEN = favorite.value(forKey: "strDescriptionEN") as? String else { return }
            guard let strCountry = favorite.value(forKey: "strCountry") as? String else { return }
            guard let strTeamBadge = favorite.value(forKey: "strTeamBadge") as? String else { return }
            guard let strTeamBanner = favorite.value(forKey: "strTeamBanner") as? String else {return}
            let teamCD = Teams(strTeam: strTeam, strLeague: strLeague, strWebsite: strWebsite, strDescriptionEN: strDescriptionEN, strCountry: strCountry, strTeamBadge: strTeamBadge, strTeamBanner: strTeamBanner)
            favoriteTeams.append(teamCD)
        }
        completion(favoriteTeams)
    }
    
    func checkIfFavorite(teamName: String) -> Bool {
        let predicate = NSPredicate(format: "strTeam = %@", teamName)
        let result = coreDataGenericService.checkObject(objectName: teamName, predicate: predicate)
        return result.count == 1 ? true: false
    }
    
    func addFavorite(team: Teams) {
        let managedObjectContext = coreDataGenericService.contextService
        guard let teamEntity = NSEntityDescription.entity(forEntityName: "TeamEntity", in: managedObjectContext) else { return }
        let favoriteEntity = NSManagedObject(entity: teamEntity, insertInto: managedObjectContext)
        favoriteEntity.setValue(team.strCountry, forKey: "strCountry")
        favoriteEntity.setValue(team.strWebsite, forKey: "strWebsite")
        favoriteEntity.setValue(team.strDescriptionEN, forKey: "strDescriptionEN")
        favoriteEntity.setValue(team.strLeague, forKey: "strLeague")
        favoriteEntity.setValue(team.strTeam, forKey: "strTeam")
        favoriteEntity.setValue(team.strTeamBadge, forKey: "strTeamBadge")
        favoriteEntity.setValue(team.strTeamBanner, forKey: "strTeamBanner")
        
        coreDataGenericService.save()
    }
    
    func deleteFromFavorite(teamName: String) {
        let predicate = NSPredicate(format: "strTeam = %@", teamName)
        coreDataGenericService.deleteObject(objectName: teamName, predicate: predicate)
    }
}

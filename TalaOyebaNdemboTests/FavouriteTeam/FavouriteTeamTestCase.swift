//
//  FavouriteTeamTestCase.swift
//  TalaOyebaNdemboTests
//
//  Created by Mikungu Giresse on 14/06/23.
//

import Foundation
@testable import TalaOyebaNdembo
import Firebase
import CoreData
import XCTest

class FavoriteModelTest: XCTestCase {
    
    func testAddAndDeleteFavorite() {
        let context = TestFavouriteTeamCoreDataStack.testContext
        let fakeDataManagement = CoreDataGenericService<TeamEntity>(context: context)
        let favoriteModel = FavouriteTeamModel(coreDataGenericService: fakeDataManagement)
        
        let label = UUID().uuidString
        let recipe = makeRecipe(label: label)
        favoriteModel.addFavorite(team: recipe)
        print(label)
        XCTAssertNotNil(recipe)
        var savedToFavorite = favoriteModel.checkIfFavorite(teamName: label)
        XCTAssertTrue(savedToFavorite)
        print(savedToFavorite)
        favoriteModel.deleteFromFavorite(teamName: label)
        print ("Calling... 22")
        print(recipe)
        savedToFavorite = favoriteModel.checkIfFavorite(teamName: label)
        XCTAssertFalse(savedToFavorite)
    }
    
    func testFavoriteWithNoTotalTime() {
        let context = TestFavouriteTeamCoreDataStack.testContext
        let fakeDataManagement = CoreDataGenericService<TeamEntity>(context: context)
        let favoriteModel = FavouriteTeamModel(coreDataGenericService: fakeDataManagement)
        
        let label = UUID().uuidString
        let recipe = makeRecipe(label: label)
        favoriteModel.addFavorite(team: recipe)
            print("Calling")
        let isFavorite = favoriteModel.checkIfFavorite(teamName: label)
            XCTAssertTrue(isFavorite)
            favoriteModel.fetchFavorites { recipes in
                XCTAssertTrue(recipes.count == 1)
                XCTAssertTrue(recipes[0].strTeam == label)
            }
    }
    
    func testAdd2FavoritesAndFetchThem() {
        let context = TestFavouriteTeamCoreDataStack.testContext
        let fakeDataManagement = CoreDataGenericService<TeamEntity>(context: context)
        let favoriteModel = FavouriteTeamModel(coreDataGenericService: fakeDataManagement)
        
        let label1 = UUID().uuidString
        let label2 = UUID().uuidString
        let recipe1 = makeRecipe(label: label1)
        let recipe2 = makeRecipe(label: label2)
        
        favoriteModel.addFavorite(team: recipe1)
        let savedToFavorite1 = favoriteModel.checkIfFavorite(teamName: label1)
            XCTAssertTrue(savedToFavorite1)
        
        favoriteModel.addFavorite(team: recipe2)
        let savedToFavorite2 = favoriteModel.checkIfFavorite(teamName: label2)
            XCTAssertTrue(savedToFavorite2)
        
        favoriteModel.fetchFavorites { recipes in
            XCTAssertNotNil(recipes)
            XCTAssertTrue(recipes.count == 2)
            XCTAssertTrue(recipe1.strTeam == label1)
            XCTAssertTrue(recipe2.strTeam == label2)
        }
    }
    
    func makeRecipe(label: String) -> Teams {
        return Teams(strTeam: label, strLeague: UUID().uuidString, strWebsite: UUID().uuidString, strDescriptionEN: UUID().uuidString, strCountry: UUID().uuidString, strTeamBadge: UUID().uuidString, strTeamBanner: UUID().uuidString)
    }
}

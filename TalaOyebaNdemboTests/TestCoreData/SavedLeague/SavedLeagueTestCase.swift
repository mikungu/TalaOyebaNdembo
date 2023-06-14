//
//  SavedLeagueTestCase.swift
//  TalaOyebaNdemboTests
//
//  Created by Mikungu Giresse on 14/06/23.
//

import Foundation
import XCTest
import Firebase
@testable import TalaOyebaNdembo

class LeagueTestCase: XCTestCase {
    
    func testgetLeague() {
        let context = TestSavedLeagueCoreDataStack.testContext
        let fakeDataManagement = CoreDataGenericService<League>(context: context)
        let leagueSavedModel = LeagueSavedModel(coreDataGenericService: fakeDataManagement)
        leagueSavedModel.getLeague { leagues in
            XCTAssertNotNil(leagues)
            XCTAssertEqual(leagues, [])
        }
    }
    
    func testSaveLeagueAndGetLeague() {
        let context = TestSavedLeagueCoreDataStack.testContext
        let fakeDataManagement = CoreDataGenericService<League>(context: context)
        let leagueSavedModel = LeagueSavedModel(coreDataGenericService: fakeDataManagement)
        
        let leagueName1 = "Ligue 1"
        leagueSavedModel.saveLeague(named: leagueName1, completion: { leagueName in
            print (leagueName)
            XCTAssertEqual(leagueName[0].name, leagueName1)
            XCTAssertTrue(leagueName.count == 1)
        })
        
        leagueSavedModel.getLeague { leagues in
            print (leagues)
            XCTAssertNotNil(leagues)
            XCTAssertEqual(leagues[0].name, leagueName1)
        }
        
        let leagueName2 = "Liga"
        let leagueName3 = "Premier League"
        leagueSavedModel.saveLeague(named: leagueName2, completion: { leagueName in
            print (leagueName2)
            XCTAssertEqual(leagueName[0].name, leagueName2)
            XCTAssertNotEqual(leagueName[0].name, leagueName3)
            XCTAssertTrue (leagueName.count == 1)
        })
        
        
    }
    
    func testDeleteLeague() {
        let context = TestSavedLeagueCoreDataStack.testContext
        let fakeDataManagement = CoreDataGenericService<League>(context: context)
        let leagueSavedModel = LeagueSavedModel(coreDataGenericService: fakeDataManagement)
        
        let leagueName1 = "Bundesliga"
        leagueSavedModel.saveLeague(named: leagueName1, completion: { leagueName in
           print (leagueName)
            XCTAssertEqual(leagueName[0].name, leagueName1)
            XCTAssertTrue(leagueName.count == 1)
        })
        
        leagueSavedModel.getLeague { leagues in
            print (leagues)
            XCTAssertNotNil(leagues)
            XCTAssertEqual(leagues[0].name, leagueName1)
        }
        
       // leagueSavedModel.deleteLeague (completion: { leagues in
        //    print (leagues)
        //    XCTAssertNotNil(leagues)
         //   XCTAssertTrue(leagues.count == 0)
            //XCTAssertTrue(leagues.exists)
        //    XCTAssertEqual(leagues[0].name, "")
            
       // })
    }
    
}

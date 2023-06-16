//
//  SearchModelTest.swift
//  TalaOyebaNdemboTests
//
//  Created by Mikungu Giresse on 14/06/23.
//

import Foundation
import XCTest
@testable import TalaOyebaNdembo
import Firebase

final class SearchModelTest: XCTestCase {
    
    //MARK: -Accessible
    let expectation = XCTestExpectation(description: "Wait for queue change")
    //MARK: -Test
    func testModelDecode () {
        
        let searchModel = SearchModel(httpClient: FakeResponseData())
        
        searchModel.getTeamsLeague { result in
            switch result {
            case .success(let value):
                print(value)
                XCTAssertTrue(true)
                XCTAssertEqual(value[0].strTeam, "Ajaccio")
                XCTAssertEqual(value[0].strCountry, "France")
                self.expectation.fulfill()
            case .failure(let error):
                print(error)
                XCTAssertFalse(true)
                XCTFail("Something wrong with my model")
            }
        }
    }
    
}

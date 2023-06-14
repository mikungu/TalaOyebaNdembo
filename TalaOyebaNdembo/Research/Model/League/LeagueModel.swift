//
//  LeagueModel.swift
//  TalaOyebaNdembo
//
//  Created by Mikungu Giresse on 14/06/23.
//

import Foundation
import Alamofire

final class LeagueModel {
    //MARK: -Properties
    private let httpClient: HTTPClient
    
    //MARK: -LifeCycle
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    var leagues = [Leagues] ()
    
    func getLeague(completion: @escaping (Result<[Leagues], Error>)-> Void) {
        let url = "https://www.thesportsdb.com/api/v1/json/50130162/all_leagues.php"
        print (url)
        let method: HTTPMethod = .get
        
        let callback: (Result<LeagueData, Error>)-> Void = { result in
            switch result {
            case .success(let model):
                print(model)
                self.leagues = model.leagues
                completion(.success(model.leagues))
            case .failure(let error):
                guard let error = error as? APIError else { break }
                print(error)
                completion (.failure(error))
            }
            
        }
        self.httpClient.request(urlString: url, method: method, completion: callback)
    }
}

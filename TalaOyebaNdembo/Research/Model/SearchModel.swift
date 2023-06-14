//
//  SearchModel.swift
//  TalaOyebaNdembo
//
//  Created by Mikungu Giresse on 14/06/23.
//

import Foundation
import Alamofire

final class SearchModel {
    //MARK: -Properties
    private let httpClient: HTTPClient
    private let leagueSavedModel = LeagueSavedModel()
    
    //MARK: -LifeCycle
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    var team = [Teams] ()
    
    
    
    func getTeamsLeague(completion: @escaping (Result<[Teams], Error>)-> Void) {
        
        leagueSavedModel.getLeague(completion: {[weak self] leaguesName in
            var league = " "
            for item in leaguesName {
                league = item.name ?? " "
            }
            
            let url = "https://www.thesportsdb.com/api/v1/json/50130162/search_all_teams.php?l=\(league)"
            print (url)
            let method: HTTPMethod = .get
            
            let callback: (Result<TeamsData, Error>)-> Void = { result in
                switch result {
                case .success(let model):
                    print(model)
                    self?.team = model.teams
                    completion(.success(model.teams))
                case .failure(let error):
                    guard let error = error as? APIError else { break }
                    print(error)
                    completion (.failure(error))
                }
                
            }
            self?.httpClient.request(urlString: url, method: method, completion: callback)
        })
    }
}

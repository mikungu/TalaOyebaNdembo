//
//  FakeResponseData.swift
//  TalaOyebaNdemboTests
//
//  Created by Mikungu Giresse on 14/06/23.
//

import Foundation
@testable import TalaOyebaNdembo

import Alamofire

//The class FakeResponseData whose role is to manage the test data
class FakeResponseData: HTTPClient {
    func request<T>(urlString: String, method: TalaOyebaNdembo.HTTPMethod, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let bundle = Bundle(for: SearchModelTest.self)
        let url = bundle.url(forResource: "TheSportsDBLeague", withExtension: "json")!
        let json = try! Data(contentsOf: url)
        
        let dataResponse = AFDataResponse<Data?>.init(request: nil, response: nil, data: json, metrics: nil, serializationDuration: .zero, result: .success(json))
        
        self.decodeServiceResponse(from: dataResponse, completion: completion)
    }
    
}

class FakeResponseDataLeague: HTTPClient {
    func request<T>(urlString: String, method: TalaOyebaNdembo.HTTPMethod, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let bundle = Bundle(for: SearchModelTest.self)
        let url = bundle.url(forResource: "TheSportsDB", withExtension: "json")!
        let json = try! Data(contentsOf: url)
        
        let dataResponse = AFDataResponse<Data?>.init(request: nil, response: nil, data: json, metrics: nil, serializationDuration: .zero, result: .success(json))
        
        self.decodeServiceResponse(from: dataResponse, completion: completion)
    }
    
}

//
//  APIService.swift
//  TalaOyebaNdembo
//
//  Created by Mikungu Giresse on 14/06/23.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case get = "Get"
    case post = "Post"
}

enum APIError: Error {
    case errorNetWork
    case parsing
    case anyerror
}

protocol HTTPClient {
    func request <T: Decodable> (urlString: String, method: HTTPMethod, completion: @escaping (Result<T, Error>) -> Void)
    func decodeServiceResponse <T: Decodable>(from response: AFDataResponse<Data?>, completion: @escaping (Result<T, Error>) -> Void)
}

extension HTTPClient {
    
    func decodeServiceResponse <T: Decodable> (from response: AFDataResponse<Data?>, completion: @escaping (Result<T, Error>) -> Void) {
        guard let data = response.data else {
            completion (.failure(APIError.errorNetWork))
            return
        }
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            completion(.success(model))
        } catch {
            completion(.failure(APIError.parsing))
        }
    }
    
}


class APIService: HTTPClient {
    
    func request<T>(urlString: String, method: HTTPMethod, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        AF.request(urlString, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            (responseData) in
            self.decodeServiceResponse(from: responseData, completion: completion)
        }
    }
    
}

//
//  FactAPI.swift
//  Dermato AI
//
//  
//

import Foundation
import Alamofire

extension API {
    func getFacts(completion: @escaping (Result<[FactModel], Error>) -> Void) {
        let url = API_URL_GET_FACTS
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response { resp in
                switch resp.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode([FactModel].self, from: data!)
                        completion(.success(data))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

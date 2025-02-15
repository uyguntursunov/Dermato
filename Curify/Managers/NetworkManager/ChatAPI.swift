//
//  ChatAPI.swift
//  Curify
//
//

import UIKit
import Alamofire

extension API {
    func sendRequest(message: String, lang: String, completion: @escaping (Result<ResponseModel, Error>) -> Void) {
//        let url = API_URL_SEND_MESSAGE + lang
        
        let url = API_URL_SEND_MESSAGE 
        
        let parameters: Parameters = [
            "message": message
         ]
        
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, interceptor: nil)
            .response { resp in
                switch resp.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(ResponseModel.self, from: data!)
                        completion(.success(data))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getChatHistory(completion: @escaping(Result<[MessageModel], Error>) -> Void) {
        let url = API_URL_GET_ALL_MESSAGES
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response { resp in
                switch resp.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode([MessageModel].self, from: data!)
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

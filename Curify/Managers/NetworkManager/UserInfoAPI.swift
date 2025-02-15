//
//  UserInfoAPI.swift
//  Curify
//
//

import UIKit
import Alamofire

extension API {
    func fillUserInfo(model: UserModel, completion: @escaping (Result<String, Error>) -> Void) {
        let url = API_URL_FILL_USER_INFO
        let headers = Token.getToken()
        
        let parameters: [String: Any] = [
            "date": model.date,
            "firstname": model.firstname,
            "gender": model.firstname,
            "id": model.Id,
            "lastname": model.lastname,
            "skin_color": model.skin_color,
            "skin_typr": model.skin_type
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
            .response { resp in
                switch resp.result {
                case .success(_):
                    completion(.success("Success"))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func showUserInfo(completion: @escaping (Result<UserModel, Error>) -> Void) {
        let url = API_URL_SHOW_USER_INFO
        let headers = Token.getToken()
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, interceptor: nil)
            .response { resp in
                switch resp.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        if let responseString = String(data: data!, encoding: .utf8) {
                            print("Response String: \(responseString)")
                        }
                        let data = try decoder.decode(UserModel.self, from: data!)
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

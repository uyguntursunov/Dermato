//
//  LoginAPI.swift
//  Curify
//
//

import UIKit
import Alamofire

extension API {
    func login(username: String, password: String, completion: @escaping (Result<AccessToken, Error>) -> Void) {
        let url = API_URL_LOGIN
        
        let parameters: [String: String] = [
            "username": username,
            "password": password
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .response{ resp in
                switch resp.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(AccessToken.self, from: data!)
                        completion(.success(data))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func register(username: String, email: String, password: String, completion: @escaping (Result<RegisterModel, Error>) -> Void) {
        let url = API_URL_REGISTER
        
        let parameters: [String: String] = [
            "email": email,
            "password": password,
            "username": username
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .response{ resp in
                switch resp.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(RegisterModel.self, from: data!)
                        completion(.success(data))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
    
    func deleteUser(completion: @escaping (Result<String, Error>) -> Void) {
        let url = API_URL_DELETE_ACCOUNT
        
        let headers = Token.getToken()
        
        AF.request(url, method: .delete, encoding: JSONEncoding.default, headers: headers)
            .response{ resp in
                switch resp.result {
                case .success(_):
                    completion(.success("Success"))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}

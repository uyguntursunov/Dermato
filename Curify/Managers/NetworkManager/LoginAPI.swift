//
//  LoginAPI.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 08/01/24.
//

import UIKit
import Alamofire

extension API {
    func login(email: String, password: String, completion: @escaping (Result<LoginModel, Error>) -> Void) {
        let url = API_URL_LOGIN
        
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .response{ resp in
                switch resp.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(LoginModel.self, from: data!)
                        completion(.success(data))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = API_URL_SIGN_UP
        
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .response{ resp in
                switch resp.result {
                case .success(_):
                    completion(.success("Success"))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
    
    func deleteUser(complition: @escaping (Result<String, Error>) -> Void) {
        let url = API_URL_DELETE_ACCOUNT
        
        let headers = Token.getToken()
        
        AF.request(url, method: .delete, encoding: JSONEncoding.default, headers: headers)
            .response{ resp in
                switch resp.result {
                case .success(_):
                    complition(.success("Success"))
                case .failure(let error):
                    complition(.failure(error))
                }
            }
    }
    
}

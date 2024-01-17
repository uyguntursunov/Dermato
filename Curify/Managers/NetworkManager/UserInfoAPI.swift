//
//  UserInfoAPI.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 08/01/24.
//

import UIKit
import Alamofire

extension API {
    func fillUserInfo(model: UserModel, completion: @escaping (Result<String, Error>) -> Void) {
        let url = API_URL_FILL_USER_INFO
        
        let parameters: [String: Any] = [
            "name": model.name,
            "weigh": model.weight,
            "height": model.height,
            "age": model.age,
            "waist": model.waist
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .response { resp in
                switch resp.result {
                case .success(_):
                    completion(.success("Success"))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
    }
}

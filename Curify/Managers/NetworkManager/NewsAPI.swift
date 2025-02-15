//
//  NewsAPI.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 26/01/24.
//

import UIKit
import Alamofire

extension API {
    func getNews(page: Int, completion: (Result<NewsModel, Error>) -> Void) {
        let url = API_URL_GET_NEWS
        
        AF.request(url, method: .get, parameters: nil, headers: nil, interceptor: nil)
            .response { resp in
                switch resp.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(NewsModel, from: data!)
                    completion(.success(data))
                }
            }
    }
}

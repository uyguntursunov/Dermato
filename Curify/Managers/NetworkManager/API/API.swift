//
//  API.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 08/01/24.
//

import UIKit
import Alamofire

let BASE_URL = "https://curifyapp.up.railway.app/v1/"
let testToken = UD.token ?? ""

class API {
    static let shared = API()
    
    // Login
    
    let API_URL_LOGIN = BASE_URL + "login"
    let API_URL_SIGN_UP = BASE_URL + "signup"
    let API_URL_DELETE_ACCOUNT = BASE_URL + "dashboard/middle/deleteAccount"
    
    
    // UserInfo
    
    let API_URL_FILL_USER_INFO = BASE_URL + "dashboard/fillUserInfo"
    
    // DrugSearch
    
    let API_URL_DRUG_SEARCH = BASE_URL + "dashboard/searchDrug?name="
    
}

class Token {
    static func getToken() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Cookie": "Authorization=\(UD.token ?? "")",
            "Postman-Token": "<calculated when request is sent>"
        ]
        return headers
    }
}


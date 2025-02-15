//
//  API.swift
//  Curify
//
//

import UIKit
import Alamofire

let BASE_URL = "https://skinai.up.railway.app/api/v1/"

class API {
    static let shared = API()
    
    // Login
    
    let API_URL_LOGIN = BASE_URL + "login"
    let API_URL_REGISTER = BASE_URL + "signup"
    let API_URL_DELETE_ACCOUNT = BASE_URL + "inner/dashboard/middle/deleteAccount"
    
    // News
    
    let API_URL_GET_NEWS = BASE_URL + "news/getall?page="
    
    // Facts
    
    let API_URL_GET_FACTS = BASE_URL + "fact/getFact"
    
    
    // UserInfo
    
    let API_URL_FILL_USER_INFO = BASE_URL + "dashboard/fillUserInfo"
    let API_URL_SHOW_USER_INFO = BASE_URL + "dashboard/middle/showUserInfo"
    
    
    // Chat
    
    let API_URL_GET_ALL_MESSAGES = BASE_URL + "inner/dashboard/middle/get-all-messages"
    let API_URL_SEND_REQUEST = BASE_URL + "inner/dashboard/middle/send-request"
    
    // Doctor
    
    let API_URL_GET_ALL_DOCTORS = BASE_URL + "doc/getalldoctors"
    let API_URL_SCHEDULE_APPPOINTMENT = BASE_URL + "schedule/create"
    let API_URL_SEARCH_DOCTOR = BASE_URL + "doc/getonedoctor?name="
    
    // ImageRecognition
    
    let API_URL_UPLOAD_IMAGE = BASE_URL + "chat/upload"
    let API_URL_SEND_MESSAGE = BASE_URL + "chat/generate"
    
}

class Token {
    static func getToken() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Cookie": "mysession=\(UD.token ?? "")"
        ]
        return headers
    }
}


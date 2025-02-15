//
//  LoginModel.swift
//  Curify
//
//

import UIKit

struct RegisterModel: Codable {
    let message: AccessToken
}

struct AccessToken: Codable {
    let access_token: String
}



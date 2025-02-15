//
//  UserModel.swift
//  Curify
//
//

import UIKit

//struct UserModel: Codable {
//    let date: String?
//    let firstname: String?
//    let gender: String?
//    let id: Int?
//    let lastname: String?
//    let skin_color: Int?
//    let skin_type: Int?
//}

struct UserModel: Codable {
    var Id: Int?
    var firstname: String?
    var lastname: String?
    var skin_color: Int?
    var skin_type: Int?
    var gender: String?
    var date: String?
}

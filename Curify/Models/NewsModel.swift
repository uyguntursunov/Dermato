//
//  NewsModel.swift
//  Curify
//
//

import UIKit

struct NewsModel: Codable {
//    let totat_count: Int?
//    let total_pages: Int?
//    let page: Int?
//    let size: Int?
//    let has_more: Bool?
    let data: [News]?
}

struct News: Codable {
    let id: Int?
    let category_id: Int?
    let date: String?
    let title: String?
    let anons: String?
    let views: Int?
    let anons_image: String?
    let url_to_web: String?
}

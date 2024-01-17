//
//  Constants.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 03/01/24.
//

import UIKit

let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)

enum SFSymbols {
    static let home = UIImage(systemName: "house.fill")
    static let drugContent = UIImage(systemName: "pill.fill")
    static let chat = UIImage(systemName: "ellipsis.message.fill")
    static let profile = UIImage(systemName: "person.fill")
    static let checkmark = UIImage(systemName: "checkmark.circle.fill", withConfiguration: largeConfig)
    static let circle = UIImage(systemName: "circle", withConfiguration: largeConfig)
    static let pill = UIImage(systemName: "pill.circle", withConfiguration: largeConfig)
}

enum Titles {
    static let home = "Home"
    static let drugContent = "DrugContent"
    static let chat = "Chat"
    static let profile = "Profile"
}
 
enum Colors {
    static let label = UIColor(red: 166/255.0, green: 77/255.0, blue: 77/255.0, alpha: 1)
    static let background = UIColor(red: 243/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1)
    static let tabBarUnselectedItem = UIColor(named: "tabBarUnselectedItem")
    static let viewBackground = UIColor(red: 255/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1)
}

enum Images {
    static let mainImage1 = UIImage(named: "mainImage1")
    static let mainImage2 = UIImage(named: "mainImage2")
    static let mainImage3 = UIImage(named: "mainImage3")
}

//
//  Constants.swift
//  Curify
//
//

import UIKit

let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .default)

enum SFSymbols {
    static let home = UIImage(systemName: "house.fill")
    static let doctors = UIImage(systemName: "cross.circle.fill")
    static let chat = UIImage(systemName: "message.fill")
    static let profile = UIImage(systemName: "person.fill")
    static let checkmark = UIImage(systemName: "checkmark.circle.fill", withConfiguration: largeConfig)
    static let circle = UIImage(systemName: "circle", withConfiguration: largeConfig)
    static let pill = UIImage(systemName: "pill.circle", withConfiguration: largeConfig)
    static let settings = UIImage(systemName: "gearshape.fill")
    static let lines3 = UIImage(systemName: "line.3.horizontal")
    static let history = UIImage(systemName: "clock")
    static let about = UIImage(systemName: "info.circle.fill")
    static let creditCard = UIImage(systemName: "creditcard.fill")
    static let logOut = UIImage(systemName: "rectangle.portrait.and.arrow.right.fill")
    static let back = UIImage(systemName: "chevron.backward")
    static let emptyChat = UIImage(systemName: "bubble.left.and.bubble.right")
    static let search = UIImage(systemName: "magnifyingglass")
    static let pen = UIImage(systemName: "square.and.pencil")
    static let send = UIImage(systemName: "arrow.up.circle.fill", withConfiguration: largeConfig)
    static let x = UIImage(systemName: "x.circle.fill")
    static let star = UIImage(systemName: "star.fill")
    static let avatar = UIImage(systemName: "person.crop.circle.fill")
    static let questionmark = UIImage(systemName: "questionmark.circle")
    static let crossCase = UIImage(systemName: "cross.case")
    static let stethoscope = UIImage(systemName: "stethoscope.circle")
    static let book = UIImage(systemName: "book.pages")
    static let question = UIImage(systemName: "questionmark.circle.fill")
    static let go = UIImage(systemName: "arrow.up.right.square")
    static let time = UIImage(systemName: "clock")
    static let location = UIImage(systemName: "mappin.and.ellipse")
    static let contact = UIImage(systemName: "phone")
    static let building = UIImage(systemName: "building")
    static let person = UIImage(systemName: "person")
    static let calendar = UIImage(systemName: "calendar")
    static let notes = UIImage(systemName: "list.clipboard")
    static let camera = UIImage(systemName: "camera")
    static let cameraFill = UIImage(systemName: "camera.fill")
    static let swap = UIImage(systemName: "arrow.triangle.2.circlepath")
    static let xmark = UIImage(systemName: "xmark")
    static let flashOn = UIImage(systemName: "bolt.fill")
    static let library = UIImage(systemName: "photo.fill.on.rectangle.fill")
    static let flashOff = UIImage(systemName: "bolt.slash.fill")
    static let lang = UIImage(systemName: "network")
    static let check = UIImage(systemName: "circle.circle.fill")
    static let clock = UIImage(systemName: "clock.fill")
    static let email = UIImage(systemName: "envelope")
    static let people = UIImage(systemName: "person.2")
    static let forward = UIImage(systemName: "chevron.right")
    static let trash = UIImage(systemName: "trash")
}

enum Titles {
    static let home = "home".translate()
    static let doctors = "Doctors"
    static let chat = "chat".translate()
    static let profile = "profile".translate()
    static let scanner = "scanner".translate()
}
 
enum Colors {
    static let label = UIColor(red: 24/255.0, green: 119/255.0, blue: 242/255.0, alpha: 1)
    static let tabBarUnselectedItem = UIColor(named: "tabBarUnselectedItem")
    static let viewBackground = UIColor(red: 255/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1)
    static let background = UIColor(named: "background")
}

enum Images {
    static let mainImage0 = UIImage(named: "mainImage0")
    static let tips = UIImage(named: "tips")
    static let doctor = UIImage(named: "doctor")
    static let curify = UIImage(named: "curify")
    static let star = UIImage(named: "star")
    static let shutter = UIImage(named: "shutter")
    static let uz = UIImage(named: "uz")
    static let en = UIImage(named: "en")
    static let step1 = UIImage(named: "step1")
    static let step2 = UIImage(named: "step2")
    static let step3 = UIImage(named: "step3")
    static let product = UIImage(named: "product")
    static let antiaging = UIImage(named: "antiaging")
    static let tip1 = UIImage(named: "tip1")
    static let tip2 = UIImage(named: "tip2")
    static let tip3 = UIImage(named: "tip3")
    static let loginPage = UIImage(named: "loginPage")
    static let dailyFacts = UIImage(named: "dailyFacts")
    static let news = UIImage(named: "news")
    static let img1 = UIImage(named: "img1")
    static let img2 = UIImage(named: "img2")
    static let img3 = UIImage(named: "img3")
    static let img4 = UIImage(named: "img4")
}

enum Alerts {
    static let loginFailed = "Please, enter valid email and password"
    static let invalidPassword = "Password must contain at least 6 characters"
    static let invalidEmail = "Please, enter a valid email"
    static let deleteAccount = "Are you sure to delete your account?"
    static let deletionFailure = "Could not delete account"
    static let wentWrong  = "Something went wrong"
    static let signUpFailure = "Could not Sign up, please check your data"
}

enum Texts {
    static let emptyChat = "Contact doctors to get consultation within 24 hours, easily add new chats and get professional help"
    static let terms = "Terms of Service \nAcceptance of Terms \n• By using our medical consultation app, you agree to comply with these terms and conditions. \nMedical Advice Disclaimer \n• The app provides information, not medical advice. Consult a qualified healthcare professional for personalized advice. \nUser Eligibility \n• Users must be 18 years or older. Minors must use the app under parental guidance. \nUser Conduct \n• Users must provide accurate information. \n• Respect other users and medical staff. No abusive language or inappropriate behavior. \nSecurity \n• Users are responsible for maintaining the confidentiality of their account information. \n• Report any unauthorized access immediately. \nIntellectual Property \n• All content and trademarks in the app are owned by us. No unauthorized use or reproduction. \nTermination \n• We reserve the right to terminate accounts violating terms without notice. \nChanges to Terms \n• We may update terms; users will be notified. Continued use implies acceptance of changes. \nPrivacy Policy \nInformation Collection \n• We collect personal and medical information to provide accurate consultations. \nUse of Information \n• Information is used for medical consultations and app improvement. \n• No sharing with third parties without user consent. \nData Security \n• Stringent measures are in place to secure user data. \n• Regular security audits to identify and fix vulnerabilities. \nUser Rights \n• Users can request access, correction, or deletion of their data. \n• Opt-out of promotional communications. \nMedical Data Handling \n• Medical data is treated with utmost confidentiality. \n• Shared with medical staff only for consultation purposes. \nCookies and Tracking \n• Cookies are used for app functionality, not for tracking personal information. \nThird-Party Links \n• We are not responsible for the privacy practices of third-party websites linked within the app. \nPolicy Changes \n• Any changes to the privacy policy will be communicated to users."
}

enum LoginType {
    case login
    case register
}

enum PostType {
    case dailyFact
    case news
}

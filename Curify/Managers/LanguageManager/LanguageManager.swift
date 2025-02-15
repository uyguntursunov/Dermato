//
//  LanguageManager.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 23/02/24.
//

import UIKit
import Localize_Swift

class LanguageManager {
    
    static func setApplLang(_ lang: AppLanguage) {
        Localize.setCurrentLanguage(lang.rawValue)
        UD.language = lang.rawValue
    }
    
    static func setAppLang(langStr: String) {
        let language = AppLanguage.language(for: langStr.lowercased())
        LanguageManager.setApplLang(language)
    }
    
    static func getAppLang() -> AppLanguage {
        return AppLanguage(rawValue: Localize.currentLanguage()) ?? .English
    }
    
    static func setDefaultLanguage () {
        setApplLang(AppLanguage(rawValue: UD.language) ?? .English)
    }
    
    static func checkLangSettings() -> Bool {
        return UD.language.isEmpty
    }
}


enum AppLanguage: String {
    case English = "en"
    case Uzbek = "uz"
    case lanDesc = "Language"
    
    static func language(for str: String) -> AppLanguage {
        if str == "en" {
            return .English
        } else if str == "uz" {
            return .Uzbek
        } else {
            return .lanDesc
        }
    }
}

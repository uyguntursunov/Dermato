//
//  UserDefaults.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 07/01/24.
//

import UIKit

let UD = UserDefaults(suiteName: "Curify")!

extension UserDefaults {
    func unarchiveObject(key: String) -> Any? {
        if let data = value(forKey: key) as? Data {
                do {
                    if let result = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, NSString.self, NSNumber.self], from: data) {
                        return (result as AnyObject).value(forKey: "Data")
                    }
                }
            return nil
        }
        return nil
    }
    
    func archivedData(key: String, object: Any) {
        let result = NSMutableDictionary()
        result.setValue(object, forKey: "Data")
            do {
                let encodedObject = try? NSKeyedArchiver.archivedData(withRootObject: result, requiringSecureCoding: false)
                set(encodedObject, forKey: key)
            }
    }
    
    var token: String? {
        get { return self.string(forKey: "token") }
        set { self.set(newValue, forKey: "token") }
    }
    
    var username: String? {
        get { return self.string(forKey: "username") }
        set { self.set(newValue, forKey: "username") }
    }
    
    var from: String? {
        get { return self.string(forKey: "from") }
        set { self.set(newValue, forKey: "from") }
    }
    
    var to: String? {
        get { return self.string(forKey: "to") }
        set { self.set(newValue, forKey: "to") }
    }
}

extension Optional {
    var notNullString: String {
        switch self {
        case .some(let value): return String(describing: value)
        case .none : return ""
        }
    }
}

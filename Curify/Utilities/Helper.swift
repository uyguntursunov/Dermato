//
//  Helper.swift
//  Curify
//
//

import UIKit

class Helper {
    static func getBottomPadding() -> CGFloat {
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.windows.first {
                let bottomSafeAreaHeight = window.safeAreaInsets.bottom
                return bottomSafeAreaHeight
            }
        } else {
            return 0.0
        }
        return 0.0
    }
    
    static func getTopPadding() -> CGFloat {
        if let window = UIApplication.shared.windows.first {
            let topSafeAreaHeight = window.safeAreaInsets.top
            return topSafeAreaHeight
        } else {
            return 0.0
        }
    }
}

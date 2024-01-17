//
//  Helper.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 09/01/24.
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
}

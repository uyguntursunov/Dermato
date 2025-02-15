//
//  AlertController+Ext.swift
//  Dermato AI
//
//  Created by Uyg'un Tursunov on 02/12/24.
//

import UIKit

extension UIAlertController {
    // Applies an attributed string to the message of an alert.
    func setAttributedMessage(_ attributedMessage: NSAttributedString) {
        self.setValue(attributedMessage, forKey: "attributedMessage")
    }
}

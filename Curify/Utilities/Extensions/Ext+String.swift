//
//  Ext+String.swift
//  Curify
//
//

import UIKit

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    func localizeString(string: String) -> String {
        
        let path = Bundle.main.path(forResource: string, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!,
                                 value: "", comment: "")
    }
    
    func translate() -> String {
        return self.localized()
    }
    
    
    // Converts Markdown-like text (e.g., **bold**) to an attributed string.
    func attributedStringFromMarkdown() -> NSAttributedString {
        let regex = try! NSRegularExpression(pattern: "\\*\\*(.*?)\\*\\*", options: [])
        let attributedString = NSMutableAttributedString(string: self)
        let matches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
        
        for match in matches.reversed() {
            let boldRange = match.range(at: 1) // Capture group for text inside **
            let fullRange = match.range(at: 0) // Full range including **
            
            let boldText = (self as NSString).substring(with: boldRange)
            
            // Apply bold styling
            let boldFont = UIFont.boldSystemFont(ofSize: 16) // Adjust size as needed
            let boldAttributedString = NSAttributedString(string: boldText, attributes: [
                .font: boldFont
            ])
            
            attributedString.replaceCharacters(in: fullRange, with: boldAttributedString)
        }
        
        return attributedString
    }
}

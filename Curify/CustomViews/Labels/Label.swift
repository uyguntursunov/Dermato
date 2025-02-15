//
//  Label.swift
//  Curify
//
//

import UIKit

class Label: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(font: UIFont) {
        self.init(frame: .zero)
        self.font = font
    }
    
    private func configure() {
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        textColor = .label
        textAlignment = .left
    }
}

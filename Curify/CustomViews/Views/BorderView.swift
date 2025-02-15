//
//  BorderView.swift
//  Curify
//
//

import UIKit

class BorderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .clear
        layer.cornerRadius = 12
        layer.borderColor = Colors.label.cgColor
        layer.borderWidth = 1
    }
}

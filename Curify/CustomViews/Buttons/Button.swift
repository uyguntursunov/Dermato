//
//  Button.swift
//  Curify
//
//

import UIKit

class Button: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
    }
    
    private func configure() {
//        backgroundColor = Colors.label
//        layer.cornerRadius = 25
        setTitleColor(.white, for: .normal)
    }
}

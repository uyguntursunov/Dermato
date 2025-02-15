//
//  SubView.swift
//  Curify
//
//

import UIKit

class ContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        clipsToBounds = false
        layer.cornerRadius = 20
        layer.shadowColor = UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 0.06).cgColor
        layer.shadowRadius = 16
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 4, height: 4)
    }
}

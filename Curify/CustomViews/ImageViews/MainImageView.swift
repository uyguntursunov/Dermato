//
//  ImageView.swift
//  Curify
//
//

import UIKit

class MainImageView: ActivityImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .clear
        contentMode = .scaleAspectFit
        clipsToBounds = true
    }
}

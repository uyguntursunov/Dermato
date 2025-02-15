//
//  ImageView.swift
//  Curify
//
//

import UIKit

class ImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuere()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configuere() {
        backgroundColor = .clear
        contentMode = .scaleAspectFit
        clipsToBounds = true
        tintColor = Colors.label
    }
}

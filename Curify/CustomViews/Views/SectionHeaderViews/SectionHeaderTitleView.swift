//
//  SectionHeaderTitleView.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 28/07/24.
//

import UIKit

class SectionHeaderTitleView: UIView {
    
    lazy var titleLabel: Label = {
        let label = Label(font: .systemFont(ofSize: 17, weight: .medium))
        return label
    }()
    
    lazy var arrowButton: 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(titleLabel)
        titleLabel.frame = CGRect(x: 5, y: 5, width: frame.width - 10, height: frame.height - 10)
    }
    
    func setData(title: String) {
        titleLabel.text = title
    }
}

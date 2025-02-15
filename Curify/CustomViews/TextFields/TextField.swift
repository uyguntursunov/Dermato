//
//  TextField.swift
//  Curify
//
//

import UIKit

class TextField: UITextField {

    lazy var viewForLeft = SubView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
    lazy var viewForRight = SubView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
    
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
        layer.borderColor = UIColor.secondaryLabel.cgColor
        layer.borderWidth = 1
        autocorrectionType = .no
        tintColor = Colors.label
        textColor = .label
        leftView = viewForLeft
        rightView = viewForRight
        leftViewMode = .always
        rightViewMode = .always
    }
}

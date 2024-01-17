//
//  TextFieldTableViewCell.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 04/01/24.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    lazy var subView = SubView(frame: .zero)
    lazy var textField = TextField(cornerRadius: 10)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(54)
        }
    }
}

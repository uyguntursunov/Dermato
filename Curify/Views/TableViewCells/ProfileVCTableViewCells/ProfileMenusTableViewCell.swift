//
//  UserDetailsTableViewCell.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 07/01/24.
//

import UIKit

class UserDetailsTableViewCell: UITableViewCell {

    lazy var subView = ContainerView(frame: .zero)
    lazy var titleLabel = Label(font: .systemFont(ofSize: 20, weight: .semibold))
    lazy var detailTextField = TextField(font: .systemFont(ofSize: 20, weight: .regular))
    
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
        
        subView.addSubview(titleLabel)
        titleLabel.text = "Date of Birth"
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        subView.addSubview(detailTextField)
        detailTextField.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalToSuperview().offset(180)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}


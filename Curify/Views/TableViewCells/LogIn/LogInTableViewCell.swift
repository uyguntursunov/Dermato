//
//  SignUpTableViewCell.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 08/01/24.
//

import UIKit

class LogInTableViewCell: UITableViewCell {

    lazy var subView = SubView(frame: .zero)
    lazy var mainImageView = MainImageView(frame: .zero)
    lazy var nameLabel = Label(font: .systemFont(ofSize: 36, weight: .bold))
    lazy var joinLabel = Label(font: .systemFont(ofSize: 20, weight: .regular))
    lazy var continueButton = Button(title: "Continue with email")
    
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
        
        subView.addSubview(mainImageView)
        mainImageView.image = Images.mainImage0
        mainImageView.layer.cornerRadius = 10
        mainImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(250)
        }
        
        subView.addSubview(nameLabel)
        nameLabel.text = "C u r i f y"
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        
        subView.addSubview(joinLabel)
        joinLabel.text = "Join thausands of happy curifies worldwide"
        joinLabel.textColor = .systemGray
        joinLabel.textAlignment = .center
        joinLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-60)
        }
    }
}

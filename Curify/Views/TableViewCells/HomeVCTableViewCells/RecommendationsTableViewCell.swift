//
//  RecommendationsTableViewCell.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 03/01/24.
//

import UIKit

class RecommendationsTableViewCell: UITableViewCell {
    
    lazy var subView = ContainerView(frame: .zero)
    lazy var avatarImageView = MainImageView(cornerRadius: 20)
    lazy var nameLabel = Label(font: UIFont.systemFont(ofSize: 17, weight: .semibold))
    lazy var recommendationLabel = Label(font: UIFont.systemFont(ofSize: 17, weight: .medium))
    
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
            make.top.leading.equalToSuperview().offset(10)
            make.bottom.trailing.equalToSuperview().offset(-10)
        }
        
        subView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.height.width.equalTo(40)
        }
        
        subView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        subView.addSubview(recommendationLabel)
        recommendationLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func setData(name: String, imageURL: String, recommendationText: String) {
        avatarImageView.loadImage(with: imageURL)
        nameLabel.text = name
        recommendationLabel.text = recommendationText
        avatarImageView.setImage(image: UIImage(systemName: "person.circle"))
    }
}

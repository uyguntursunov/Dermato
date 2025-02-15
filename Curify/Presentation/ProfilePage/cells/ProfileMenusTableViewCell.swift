//
//  ProfileMenusTableViewCell.swift
//  Curify
//
//

import UIKit

class ProfileMenusTableViewCell: UITableViewCell {

    lazy var subView = SubView(frame: .zero)
    lazy var titleLabel = Label(font: .systemFont(ofSize: 20, weight: .regular))
    lazy var iconImageView = ImageView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        self.backgroundColor = .clear
        
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(15)
            make.height.width.equalTo(30)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        subView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func setData(model: Instruction) {
        titleLabel.text = model.title
        iconImageView.image = model.image
    }
}


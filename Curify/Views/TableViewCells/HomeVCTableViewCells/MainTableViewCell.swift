//
//  MainTableViewCell.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 03/01/24.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    lazy var subView = ContainerView(frame: .zero)
    lazy var mainImageView = MainImageView(cornerRadius: 0)
    lazy var titleLabel = Label(font: .systemFont(ofSize: 20, weight: .semibold))
    lazy var progressLabel = Label(font: .systemFont(ofSize: 15, weight: .medium))
    lazy var progressPercentageLabel = Label(font: .systemFont(ofSize: 15, weight: .medium))
    
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
        
        subView.addSubview(mainImageView)
        mainImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(180)
        }
        
        subView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(mainImageView.snp.leading).offset(-10)
        }
        
        subView.addSubview(progressLabel)
        progressLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        subView.addSubview(progressPercentageLabel)
        progressPercentageLabel.snp.makeConstraints { make in
            make.leading.equalTo(progressLabel.snp.trailing).offset(5)
            make.centerY.equalTo(progressLabel)
        }
    }
    
    func setData(image: UIImage, title: String, progress: String) {
        mainImageView.image = image
        titleLabel.text = title
        progressLabel.text = "Progress:"
        progressPercentageLabel.text = progress + "%"
    }
}

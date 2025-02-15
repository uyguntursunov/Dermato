//
//  ScanTutorialTableViewCell.swift
//  Curify
//
//  
//

import UIKit

class ScanTutorialTableViewCell: UITableViewCell {

    lazy var containerView = ContainerView(frame: .zero)
    
    lazy var mainImageView: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    lazy var contentLabel = Label(font: .systemFont(ofSize: 16, weight: .medium))
    lazy var stepLabel: Label = {
        let label = Label(font: .systemFont(ofSize: 15, weight: .regular))
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        containerView.addSubview(mainImageView)
        mainImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.height.width.equalTo(80)
        }
        
        containerView.addSubview(stepLabel)
        stepLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView)
            make.leading.equalTo(mainImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
        }
        
        containerView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(stepLabel.snp.bottom)
            make.leading.equalTo(stepLabel)
            make.trailing.bottom.equalToSuperview().offset(-15)
        }
    }
    
    func setData(model: Instruction, num: Int) {
        mainImageView.image = model.image
        stepLabel.text = "Step " + "\(num)"
        contentLabel.text = model.title
    }
    
}

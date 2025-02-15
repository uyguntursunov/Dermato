//
//  ScansHistoryTableViewCell.swift
//  Curify
//
//  
//

import UIKit

class ScansHistoryTableViewCell: UITableViewCell {

    lazy var subView: SubView = {
        let view = SubView(frame: .zero)
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.systemGray6.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var mainImageView: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    lazy var titleLabel: Label = {
        let label = Label(font: .systemFont(ofSize: 16, weight: .medium))
        label.numberOfLines = 2
        return label
    }()
    
    lazy var dateLabel: Label = {
        let label = Label(font: .systemFont(ofSize: 16, weight: .regular))
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
        
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        subView.addSubview(mainImageView)
        mainImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(80)
            make.width.equalTo(100)
        }
        
        subView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.leading.equalTo(mainImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-35)
        }
        
        subView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func setData(model: ScanItem) {
        titleLabel.text = model.title
        dateLabel.text = model.date
        if let data = model.image {
            mainImageView.image = UIImage(data: data)
        }
    }

}

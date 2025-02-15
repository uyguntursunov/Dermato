//
//  DoctorsCollectionViewCell.swift
//  Curify
//
//  
//

import UIKit

class DoctorsCollectionViewCell: UICollectionViewCell {
    
    lazy var subView: SubView = {
        let view = SubView(frame: .zero)
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var imageView: MainImageView = {
        let imageView = MainImageView(frame: .zero)
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        imageView.image = Images.doctor
        return imageView
    }()
    
    lazy var nameLabel: Label = {
        let label = Label(font: .systemFont(ofSize: 17, weight: .medium))
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.text = ""
        return label
    }()
    
    lazy var workTimeIcon: ImageView = {
        let icon = ImageView(frame: .zero)
        icon.image = SFSymbols.time
        return icon
    }()
    
    lazy var workingHoursLabel: Label = {
        let label = Label(font: .systemFont(ofSize: 14, weight: .regular))
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initViews() {
        self.backgroundColor = .clear
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(5)
            make.bottom.trailing.equalToSuperview().offset(-5)
        }
        
        subView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(130)
        }
        
        subView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(imageView)
        }
        
        subView.addSubview(workTimeIcon)
        workTimeIcon.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.height.width.equalTo(15)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        subView.addSubview(workingHoursLabel)
        workingHoursLabel.snp.makeConstraints { make in
            make.centerY.equalTo(workTimeIcon)
            make.leading.equalTo(workTimeIcon.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
    
    func setData(model: DoctorModel) {
        nameLabel.text = model.name
        workingHoursLabel.text = model.work_hours
        imageView.loadImage(with: model.photo)
    }
}

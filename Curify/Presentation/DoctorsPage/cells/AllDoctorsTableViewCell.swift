//
//  AllDoctorsTableViewCell.swift
//  Curify
//
//

import UIKit
import SwiftyStarRatingView

class AllDoctorsTableViewCell: UITableViewCell {

    lazy var subView: SubView = {
        let view = SubView(frame: .zero)
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var mainImageView: MainImageView = {
        let imageView = MainImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    lazy var nameLabel: Label = {
        let label = Label(font: .systemFont(ofSize: 17, weight: .medium))
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var workTimeIcon: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.image = SFSymbols.time
        return imageView
    }()
    
    lazy var workingHoursLabel: Label = {
        let label = Label(font: .systemFont(ofSize: 17, weight: .regular))
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
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
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        subView.addSubview(mainImageView)
        mainImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        subView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-15)
            make.leading.equalTo(mainImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        subView.addSubview(workTimeIcon)
        workTimeIcon.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.centerY.equalToSuperview().offset(15)
            make.height.width.equalTo(20)
        }
        
        subView.addSubview(workingHoursLabel)
        workingHoursLabel.snp.makeConstraints { make in
            make.centerY.equalTo(workTimeIcon)
            make.leading.equalTo(workTimeIcon.snp.trailing).offset(5)
        }
    }
    
    func setData(model: DoctorModel) {
        mainImageView.loadImage(with: model.photo)
        nameLabel.text = model.name
        workingHoursLabel.text = model.work_hours
    }
}

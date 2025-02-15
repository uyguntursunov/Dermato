//
//  DoctorDetailsTableViewCell.swift
//  Curify
//
//  
//

import UIKit

class DoctorDetailsTableViewCell: UITableViewCell {

    weak var delegate: DoctorDetailsViewControllerDelegate?
    
    let width = UIScreen.main.bounds.width
    lazy var subView = SubView(frame: .zero)
    lazy var nameLabel = Label(font: .systemFont(ofSize: 24, weight: .bold))
    lazy var workLabel = Label(font: .systemFont(ofSize: 17, weight: .medium))
    
    lazy var ratingLabel = Label(font: .systemFont(ofSize: 17, weight: .medium))
    
    lazy var workTimeLabel = Label(font: .systemFont(ofSize: 17, weight: .semibold))
    lazy var workTime = Label(font: .systemFont(ofSize: 17, weight: .regular))
    
    lazy var locationLabel = Label(font: .systemFont(ofSize: 17, weight: .semibold))
    lazy var location = Label(font: .systemFont(ofSize: 17, weight: .regular))
    
    lazy var contactLabel = Label(font: .systemFont(ofSize: 17, weight: .semibold))
    lazy var contact = Label(font: .systemFont(ofSize: 17, weight: .regular))
    
    lazy var starImage: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.image = Images.star
        return imageView
    }()
    
    lazy var workTimeIcon: ImageView = {
        let icon = ImageView(frame: .zero)
        icon.image = SFSymbols.time
        return icon
    }()
    
    lazy var locationIcon: ImageView = {
        let icon = ImageView(frame: .zero)
        icon.image = SFSymbols.location
        return icon
    }()
    
    lazy var contactIcon: ImageView = {
        let icon = ImageView(frame: .zero)
        icon.image = SFSymbols.contact
        return icon
    }()
    
    lazy var scheduleButton: Button = {
        let button = Button(title: "Schedule an appointment")
        button.addTarget(self, action: #selector(scheduleButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func scheduleButtonPressed() {
        delegate?.scheduleButtonPressed()
    }
    
    private func initViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        subView.addSubview(workLabel)
        workLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(nameLabel)
        }
        
        subView.addSubview(ratingLabel)
        ratingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(workLabel)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        subView.addSubview(starImage)
        starImage.snp.makeConstraints { make in
            make.centerY.equalTo(workLabel)
            make.trailing.equalTo(ratingLabel.snp.leading).offset(-5)
        }
        
        subView.addSubview(workTimeLabel)
        workTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(workLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(workLabel)
        }
        
        subView.addSubview(workTimeIcon)
        workTimeIcon.snp.makeConstraints { make in
            make.top.equalTo(workTimeLabel.snp.bottom).offset(5)
            make.leading.equalTo(workTimeLabel)
            make.height.width.equalTo(20)
        }
        
        subView.addSubview(workTime)
        workTime.snp.makeConstraints { make in
            make.centerY.equalTo(workTimeIcon)
            make.leading.equalTo(workTimeIcon.snp.trailing).offset(5)
        }
        
        subView.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(workTime.snp.bottom).offset(20)
            make.leading.equalTo(workTimeLabel)
        }
        
        subView.addSubview(locationIcon)
        locationIcon.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(5)
            make.leading.equalTo(locationLabel)
            make.height.width.equalTo(20)
        }
        
        subView.addSubview(location)
        location.snp.makeConstraints { make in
            make.centerY.equalTo(locationIcon)
            make.leading.equalTo(locationIcon.snp.trailing).offset(5)
        }
        
        subView.addSubview(contactLabel)
        contactLabel.snp.makeConstraints { make in
            make.top.equalTo(location.snp.bottom).offset(20)
            make.leading.equalTo(workTimeLabel)
        }
        
        subView.addSubview(contactIcon)
        contactIcon.snp.makeConstraints { make in
            make.top.equalTo(contactLabel.snp.bottom).offset(5)
            make.leading.equalTo(contactLabel)
            make.height.width.equalTo(20)
        }
        
        subView.addSubview(contact)
        contact.snp.makeConstraints { make in
            make.centerY.equalTo(contactIcon)
            make.leading.equalTo(contactIcon.snp.trailing).offset(5)
        }
        
        subView.addSubview(scheduleButton)
        scheduleButton.snp.makeConstraints { make in
            make.top.equalTo(contact.snp.bottom).offset(100)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
        }
    }
    
    func setData(model: DoctorModel) {
        workTimeLabel.text = "Working time"
        locationLabel.text = "Working place"
        contactLabel.text = "Contact"
        nameLabel.text = model.name
        workLabel.text = model.type
        if let rating = model.rating {
            ratingLabel.text = "\(rating)"
        }
        workTime.text = model.work_hours
        location.text = model.workplace
        contact.text = model.phone_number
    }
}

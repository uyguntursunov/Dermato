//
//  PersonalInfoTableViewCell.swift
//  Curify
//
//  
//

import UIKit

class PersonalInfoTableViewCell: UITableViewCell {
    
    var isName: Bool = false
    var isDate: Bool = false
    var isGender: Bool = false
    
    var textChanged: ((String) -> Void)?
    
    lazy var subView = SubView(frame: .zero)
    lazy var titleLabel = Label(font: .systemFont(ofSize: 17, weight: .regular))
    
    lazy var avatarImageView: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.tintColor = .label
        return imageView
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.font = .systemFont(ofSize: 17, weight: .regular)
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var genderNameLabel: Label = {
        let label = Label(font: .systemFont(ofSize: 17, weight: .regular))
        label.tintColor = .secondaryLabel
        return label
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .systemBackground
        datePicker.datePickerMode = .date
        datePicker.tintColor = Colors.label
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        datePicker.addTarget(self, action: #selector(updatedValue), for: .valueChanged)
        return datePicker
    }()
    
    lazy var forwardImageView: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.image = SFSymbols.forward
        imageView.tintColor = .secondaryLabel
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textChanged?(textField.text ?? "")
    }
    
    @objc func updatedValue() {
        donePick()
    }
    
    func donePick() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //        delegate?.didSlectDate(date: dateFormatter.string(from: datePicker.date))
    }
    
    private func initViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(25)
            make.width.equalTo(30)
        }
        
        subView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        subView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(10)
        }
        
        subView.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(35)
        }
        
        subView.addSubview(forwardImageView)
        forwardImageView.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView)
            make.trailing.equalToSuperview().offset(-15)
            make.height.width.equalTo(20)
        }
        
        subView.addSubview(genderNameLabel)
        genderNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView)
            make.trailing.equalTo(forwardImageView.snp.leading).offset(-10)
        }
    }
    
    func setData() {
        
    }
    
    func configure(model: Instruction) {
        avatarImageView.image = model.image
        textField.placeholder = model.title
        titleLabel.text = model.title
    }
    
    func configureCell() {
        textField.isHidden = isDate || isGender
        titleLabel.isHidden = isName
        genderNameLabel.isHidden = isDate || isName
        datePicker.isHidden = isName || isGender
        forwardImageView.isHidden = isDate || isName
        isName = false
        isDate = false
        isGender = false
    }
}

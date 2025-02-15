//
//  ScheduleTableViewCell.swift
//  Curify
//
//  
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    var isDate: Bool = false
    var isChecked: Bool = false
    var isLast: Bool = false
    var index: Int = 0
    
    weak var delegate: ScheduleViewControllerDelegate?
    
    lazy var subView = SubView(frame: .zero)
    lazy var avatarImageView = ImageView(frame: .zero)
    lazy var textField: TextField = {
        let textField = TextField(font: .systemFont(ofSize: 17, weight: .regular))
        textField.layer.borderWidth = 0
        textField.addTarget(self, action: #selector(textFieldValueChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .systemBackground
        datePicker.datePickerMode = .dateAndTime
        datePicker.tintColor = Colors.label
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())
        datePicker.addTarget(self, action: #selector(updatedValue), for: .valueChanged)
        return datePicker
    }()
    
    lazy var tickButton: Button = {
        let button = Button(frame: .zero)
        button.setImage(SFSymbols.circle, for: .normal)
        button.backgroundColor = .clear
        button.tintColor = Colors.label
        button.addTarget(self, action: #selector(tickButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var label = Label(font: .systemFont(ofSize: 17, weight: .regular))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tickButtonAction() {
        isChecked.toggle()
        let image = isChecked ? SFSymbols.checkmark : SFSymbols.circle
        tickButton.setImage(image, for: .normal)
        let isAgree: Int = isChecked ? 1 : 0
        delegate?.didAgree(isAgree: isAgree)
    }
    
    @objc func updatedValue() {
        donePick()
    }
    
    func donePick() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        delegate?.didSlectDate(date: dateFormatter.string(from: datePicker.date))
    }
    
    @objc func textFieldValueChanged(_ sender: UITextField) {
        if let text = sender.text, !text.isEmpty {
            delegate?.textFieldDidChange(index: index, text: text)
        }
    }
    
    private func initViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        setCell()
        
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(15)
            make.height.width.equalTo(30)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        subView.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(20)
            make.height.equalTo(30)
        }
        
        subView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        subView.addSubview(tickButton)
        tickButton.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(25)
        }
        
        subView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(tickButton)
            make.leading.equalTo(tickButton.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    
    func setData(imageString: String, placeholder: String) {
        if !isLast { avatarImageView.image = UIImage(systemName: imageString) }
        if !isDate { textField.placeholder = placeholder }
        if isLast {label.text = "I'm agree to provide doctor with diagnosis from AI chat assistant."}
        setCell()
    }
    
    func setCell() {
        textField.isHidden = isDate || isLast ? true : false
        datePicker.isHidden = isDate ? false : true
        tickButton.isHidden = isLast ? false : true
        label.isHidden = isLast ? false : true
    }
}


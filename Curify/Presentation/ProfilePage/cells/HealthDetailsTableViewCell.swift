//
//  HealthDetailsTableViewCell.swift
//  Curify
//
//

import UIKit

protocol HealthDetailsTableViewCellDelegate: AnyObject {
    func healthDetailsTableViewCell(_ levelTableViewCell: HealthDetailsTableViewCell, didEndEditingWithText: String?)
}

class HealthDetailsTableViewCell: UITableViewCell {

    lazy var subView = SubView(frame: .zero)
    lazy var titleLabel = Label(font: .systemFont(ofSize: 20, weight: .medium))
    lazy var detailTextField = TextField(font: .systemFont(ofSize: 20, weight: .regular))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        subView.addSubview(detailTextField)
        detailTextField.layer.borderWidth = 0
        detailTextField.placeholder = "notEntered".translate()
        detailTextField.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalToSuperview().offset(150)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    func setData(title: String) {
        titleLabel.text = title
    }
}

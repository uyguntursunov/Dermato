//
//  CurifyChatTableViewCell.swift
//  Curify
//
//

import UIKit

class CurifyChatTableViewCell: UITableViewCell {

    lazy var subView = SubView(frame: .zero)
    lazy var mainImageView = ImageView(frame: .zero)
    
    lazy var nameLabel: Label = {
       let label = Label(font: .systemFont(ofSize: 17, weight: .medium))
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
        self.backgroundColor = .clear
        self.selectionStyle = .none
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(mainImageView)
        mainImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(30)
            make.width.equalTo(40)
        }
        
        subView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(mainImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func setData(model: Instruction) {
        nameLabel.text = model.title
        mainImageView.image = model.image
    }
}

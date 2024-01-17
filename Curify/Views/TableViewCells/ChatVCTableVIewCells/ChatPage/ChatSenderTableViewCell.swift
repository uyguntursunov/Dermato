//
//  ChatSenderTableViewCell.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 09/01/24.
//

import UIKit

class ChatSenderTableViewCell: UITableViewCell {

    lazy var subView = SubView(frame: .zero)
    lazy var containerView = SubView(frame: .zero)
    lazy var mainLabel = Label(font: .systemFont(ofSize: 17, weight: .regular))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(text: String) {
        mainLabel.text = text
    }
    
    private func initView() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(containerView)
        containerView.layer.cornerRadius = 16
        containerView.backgroundColor = Colors.label
        containerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(UIScreen.main.bounds.width * 3 / 4)
            make.right.equalToSuperview().offset(-16)
        }
        
        containerView.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().offset(-10)
        }
    }
}

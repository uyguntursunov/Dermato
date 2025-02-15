//
//  ChatBottomView.swift
//  Curify
//
//

import UIKit

protocol ChatControllerDelegate: AnyObject {
    func sendButtonTapped()
}

class ChatBottomSendView: UIView {
    
    var callback: (() -> Void)?
    weak var delegate: ChatControllerDelegate?
    lazy var subView = SubView(frame: .zero)
    lazy var containerView = SubView(frame: .zero)
    
    lazy var textField: TextField = {
        let textField = TextField(font: .systemFont(ofSize: 17, weight: .regular))
        textField.backgroundColor = .systemBackground
        textField.layer.cornerRadius = 20
        textField.placeholder = "message".translate()
        return textField
    }()
    
    lazy var sendButton: Button = {
        let button = Button(frame: .zero)
        button.setImage(SFSymbols.send, for: .normal)
        button.tintColor = Colors.label
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        self.addSubview(subView)
        subView.backgroundColor = .secondarySystemBackground
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(sendButton)
        sendButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10 - Helper.getBottomPadding())
            make.height.width.equalTo(40)
        }
        
        subView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10 - Helper.getBottomPadding())
            make.height.equalTo(40)
            make.trailing.equalTo(sendButton.snp.leading).offset(-5)
        }
        
        containerView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func sendButtonTapped() {
        delegate?.sendButtonTapped()
    }
    
    func getText() -> String? {
        if let text = textField.text {
            return text
        }
        return ""
    }
    
    func setText(_ text: String) {
        textField.text = text
    }
}


//
//  ChatBottomView.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 09/01/24.
//

import UIKit

protocol ChatControllerDelegate: AnyObject {
    func sendButtonTapped()
}

class ChatBottomSendView: UIView {
    
    var callback: (() -> Void)?
    weak var delegate: ChatControllerDelegate?
    lazy var subView = SubView(frame: .zero)
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "chatcellColor")
        view.layer.cornerRadius = 45.0 / 2
        return view
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.autocorrectionType = .no
        let placeholderText = "enter_text".translate()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.placeHolderColor,
            .font: UIFont.systemFont(ofSize: 17)
        ]
        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        let attributes2: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 17)
        ]
        let attributedText = NSAttributedString(string: "", attributes: attributes2)
        textField.attributedText = attributedText
        textField.tintColor = UIColor.mainColor
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    let sendButton = LoadingButton(icon: UIImage(systemName: "mic.fill"), buttonStyle: .fill)

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
        sendButton.indicator = LineScalePulseIndicator(color: .white)
        sendButton.layer.cornerRadius = 45.0 / 2
        sendButton.bgColor = .mainColor
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        sendButton.showLoader(userInteraction: false)
        sendButton.tintColor = .white
        sendButton.hideLoader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        self.addSubview(subView)
        subView.backgroundColor = UIColor(named: "tabbar")
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(sendButton)
        sendButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10 - Helper.getBottomPadding())
            make.height.width.equalTo(45)
        }
        
        subView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10 - Helper.getBottomPadding())
            make.height.equalTo(45)
            make.right.equalTo(sendButton.snp.left).offset(-16)
        }
        
        containerView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-0)
        }
    }
    
    func setMicrofone() {
        sendButton.setImage(UIImage(systemName: "mic.fill"))
        isMicrophone = true
    }
        
    @objc func sendButtonTapped() {
        if isMicrophone {
            delegate?.microphoneTapped()
        } else {
            delegate?.sendButtonTapped()
            sendButton.showLoader(userInteraction: false)
        }
    }
    
    func hideLoadingView() {
        sendButton.hideLoader()
        sendButton.isUserInteractionEnabled = false
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
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text?.replacingOccurrences(of: " ", with: "") == "" {
            isMicrophone = true
        } else {
            isMicrophone = false
        }
    }
}


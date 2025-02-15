//
//  ChatReceiverTableViewCell.swift
//  Curify
//
//

import UIKit
import NVActivityIndicatorView

class ChatReceiverTableViewCell: UITableViewCell {

    var isLoading: Bool = false {
        didSet {
            configureCell()
        }
    }
    
    lazy var subView = SubView(frame: .zero)
    
    lazy var activityView: NVActivityIndicatorView = {
        let view = NVActivityIndicatorView(frame: .zero)
        view.type = .ballPulse
        view.color = .secondaryLabel
        view.padding = 15
        return view
    }()
    
    lazy var contentLabel: Label = {
        let label = Label(font: .systemFont(ofSize: 17, weight: .regular))
        label.textColor = .label
        return label
    }()
    
    lazy var containerView: SubView = {
        let view = SubView(frame: .zero)
        view.layer.cornerRadius = 16
        view.backgroundColor = .systemGray6
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(text: String) {
        contentLabel.attributedText = text.attributedStringFromMarkdown()
//        contentLabel.text = text
    }
    
    func configureCell() {
        activityView.isHidden = !isLoading
        isLoading ? activityView.startAnimating() : activityView.stopAnimating()
    }
    
    private func initView() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(containerView)
        containerView.addSubview(contentLabel)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-UIScreen.main.bounds.width / 4)
        }
        
        containerView.addSubview(activityView)
        activityView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        
        containerView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().offset(-10)
        }
    }

}

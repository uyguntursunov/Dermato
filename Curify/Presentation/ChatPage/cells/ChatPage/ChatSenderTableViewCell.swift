//
//  ChatSenderTableViewCell.swift
//
//
//

import UIKit
import SnapKit

class ChatSenderTableViewCell: UITableViewCell {
    
    lazy var subView = SubView(frame: .zero)
    
    lazy var mainLabel: Label = {
        let label = Label(font: .systemFont(ofSize: 17, weight: .regular))
        label.textColor = .white
        return label
    }()
    
    lazy var containerView: SubView = {
        let view = SubView(frame: .zero)
        view.layer.cornerRadius = 17
        view.backgroundColor = Colors.label
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private var containerLeadingConstraint: Constraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(text: String) {
        mainLabel.text = text
        updateContainerViewConstraints()
    }
    
    private func initView() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(containerView)
        containerView.addSubview(mainLabel)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(UIScreen.main.bounds.width / 4)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().offset(-10)
        }
    }
    
    private func updateContainerViewConstraints() {
//        // Ensure layout has been updated before measuring
//        contentView.layoutIfNeeded()
//        
//        let labelWidth = mainLabel.intrinsicContentSize.width
//        let screenWidth = UIScreen.main.bounds.width
//        
//        // Calculate the new leading offset
//        let newLeadingOffset: CGFloat
//        if labelWidth < screenWidth / 2 {
//            containerView.snp.updateConstraints { make in
//                make.leading.equalToSuperview().offset(screenWidth - labelWidth - 40)
//            }
//        } else {
//            containerView.snp.updateConstraints { make in
//                make.leading.equalToSuperview().offset(screenWidth / 4)
//            }
//        }
    }
}

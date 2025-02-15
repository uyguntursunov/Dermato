//
//  QuizTableViewCell.swift
//  Dermato AI
//
//  
//

import UIKit

class QuizAnswerTableViewCell: UITableViewCell {
    
    lazy var subView: SubView = {
        let subView = SubView(frame: .zero)
        subView.backgroundColor = .secondarySystemBackground
        return subView
    }()
    
    lazy var answerLabel: Label = {
       let label = Label(font: .systemFont(ofSize: 17, weight: .medium))
        label.textAlignment = .center
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
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(5)
            make.trailing.bottom.equalToSuperview().offset(-5)
        }
        
        subView.addSubview(answerLabel)
        answerLabel.text = "A balanced approach towards healthier choices"
        answerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.center.equalToSuperview()
        }
    }
    
}

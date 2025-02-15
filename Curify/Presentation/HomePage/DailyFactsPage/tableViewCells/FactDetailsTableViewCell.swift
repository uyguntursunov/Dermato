//
//  FactDetailsTableViewCell.swift
//  Dermato AI
//
//  
//

import UIKit

class FactDetailsTableViewCell: UITableViewCell {
    
    lazy var subview = SubView(frame: .zero)
    lazy var titleLabel = Label(font: .systemFont(ofSize: 20, weight: .semibold))
    lazy var detailsLabel = Label(font: .systemFont(ofSize: 20, weight: .semibold))
    lazy var contentLabel = Label(font: .systemFont(ofSize: 17, weight: .regular))
    
    lazy var questionIcon: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.tintColor = .secondaryLabel
        imageView.image = SFSymbols.questionmark
        return imageView
    }()
    
    lazy var numOfQuestionsLabel: Label = {
       let label = Label(font: .systemFont(ofSize: 17, weight: .regular))
        label.textColor = .secondaryLabel
        return label
    }()
    
    lazy var numberLabel: Label = {
       let label = Label(font: .systemFont(ofSize: 17, weight: .regular))
        label.textColor = .secondaryLabel
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
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(subview)
        subview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subview.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        subview.addSubview(questionIcon)
        questionIcon.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel)
            make.height.width.equalTo(20)
        }
        
        subview.addSubview(numOfQuestionsLabel)
        numOfQuestionsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(questionIcon)
            make.leading.equalTo(questionIcon.snp.trailing).offset(5)
        }
        
        subview.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(questionIcon)
            make.leading.equalTo(numOfQuestionsLabel.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        subview.addSubview(detailsLabel)
        detailsLabel.snp.makeConstraints { make in
            make.top.equalTo(questionIcon.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel)
        }
        
        subview.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(detailsLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-100)
        }
    }
    
    func setData(model: FactModel) {
        titleLabel.text = model.title
        numOfQuestionsLabel.text = "Number of questions:"
        numberLabel.text = String(describing: model.number_of_question ?? 1)
        detailsLabel.text = "Details"
        contentLabel.text = model.content
    }
}

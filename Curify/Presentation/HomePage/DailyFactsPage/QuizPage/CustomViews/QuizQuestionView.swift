//
//  QuizQuestionView.swift
//  Dermato AI
//
//  
//

import UIKit

class QuizQuestionView: UIView {
    
    lazy var questionLabel: Label = {
       let label = Label(font: .systemFont(ofSize: 17, weight: .medium))
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapStartButton() {
        
    }
    
    private func initViews() {
        
        backgroundColor = .systemBackground
        
        addSubview(questionLabel)
        questionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.center.equalToSuperview()
        }
    }
}


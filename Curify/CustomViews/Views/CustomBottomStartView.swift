//
//  CustomBottomView.swift
//  Dermato AI
//
//  
//

import UIKit

class CustomBottomStartView: UIView {
    
    lazy var startButton: Button = {
        let button = Button(title: "Start")
        button.backgroundColor = Colors.label
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        startButton.setTitle(title, for: .normal)
    }
    
    @objc func didTapStartButton() {
        
    }
    
    private func initViews() {
        
        backgroundColor = .systemBackground
        
        addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(50)
        }
    }
}

//
//  SectionHeaderView.swift
//  Curify
//
//

import UIKit

class SectionHeaderView: UIView {
    
    weak var doctorDelegate: DoctorsViewControllerDelegate?
    
    var section: Int = 0
    
    lazy var subView = SubView(frame: .zero)
    lazy var titleLabel = Label(font: .systemFont(ofSize: 20, weight: .semibold))
    lazy var allButton: Button = {
        let button = Button(title: "All")
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.layer.cornerRadius = 10
        button.backgroundColor = .secondarySystemBackground
        button.addTarget(self, action: #selector(allButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func allButtonPressed() {
        doctorDelegate?.allButtonPressed(section: section)
    }
    
    func configure() {
        addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        subView.addSubview(allButton)
        allButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(25)
            make.width.equalTo(50)
        }
    }
    
    func setData(title: String) {
        titleLabel.text = title
    }
}

//
//  SectionHeaderTitleView.swift
//  Curify
//
//  
//

import UIKit

class SectionHeaderTitleView: UIView {
    
    lazy var subView = SubView(frame: .zero)
    lazy var titleLabel = Label(font: .systemFont(ofSize: 20, weight: .semibold))
    
    lazy var chevronImageView: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.tintColor = .label
        imageView.image = SFSymbols.forward
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        subView.addSubview(chevronImageView)
        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.height.width.equalTo(25)
        }
    }
    
    func setData(title: String) {
        titleLabel.text = title
    }
}

//
//  HomeSectionsTableViewCell.swift
//  Curify
//
//  
//

import UIKit

class HomeSectionsTableViewCell: UITableViewCell {
    
    weak var delegate: HomeViewControllerDelegate?
    
    lazy var subView = SubView(frame: .zero)
    
    lazy var mainImageView: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    lazy var startButton: Button = {
        let button = Button(title: "Get Started")
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.isUserInteractionEnabled = false
//        button.addTarget(self, action: #selector(didPressStart), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didPressStart() {
    }
    
    private func initViews() {
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(mainImageView)
        mainImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
            make.height.equalTo(190)
        }
        
        subView.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.centerX.equalTo(mainImageView)
            make.leading.equalTo(mainImageView).offset(100)
            make.trailing.equalTo(mainImageView).offset(-100)
            make.bottom.equalTo(mainImageView).offset(-20)
            make.height.equalTo(40)
        }
    }
    
    func setData(type: PostType) {
        switch type {
        case .dailyFact:
            mainImageView.image = Images.dailyFacts
            startButton.setTitle("Get Started", for: .normal)
        case .news:
            mainImageView.image = Images.news
            startButton.setTitle("More", for: .normal)
        }
    }
}

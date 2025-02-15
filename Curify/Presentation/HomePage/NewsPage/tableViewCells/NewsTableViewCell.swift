//
//  NewsTableViewCell.swift
//  Curify
//
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    var urlString: String?
    weak var delegate: NewsViewControllerDelegate?
    
    lazy var subView = SubView(frame: .zero)
    lazy var titleLabel = Label(font: .systemFont(ofSize: 20, weight: .medium))
    lazy var dateLabel = Label(font: .systemFont(ofSize: 14, weight: .regular))
    lazy var mainImageView: MainImageView = {
        let imageView = MainImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    lazy var goButton: UIButton =  {
        let button = UIButton()
        button.setImage(SFSymbols.go, for: .normal)
        button.tintColor = Colors.label
        button.addTarget(self, action: #selector(goButtonPressed), for: .touchUpInside)
        return button
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func goButtonPressed() {
        if let urlString = urlString {
            delegate?.didSelectNews(urlString: urlString)
        }
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
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(200)
        }
        
        subView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(15)
            make.leading.trailing.equalTo(mainImageView)
        }
        
        subView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        subView.addSubview(goButton)
        goButton.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel)
            make.trailing.equalTo(titleLabel)
            make.height.width.equalTo(30)
        }
    }
    
    func setData(model: News) {
        mainImageView.loadImage(with: model.anons_image)
        titleLabel.text = model.title
        dateLabel.text = model.date
        urlString = model.url_to_web
    }
    
}

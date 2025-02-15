//
//  ChangeLangTableViewCell.swift
//  Curify
//
//  
//

import UIKit

class ChangeLangTableViewCell: UITableViewCell {
    
    lazy var subView = SubView(frame: .zero)
    lazy var langLabel = Label(font: .systemFont(ofSize: 17, weight: .medium))
    var isChosen: Bool = false {
        didSet {
            updateCheckStatus()
        }
    }
    
    lazy var circleImageView: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.image = SFSymbols.circle
        imageView.tintColor = .label
        return imageView
    }()
    
    lazy var flagImageView: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.image = Images.uz
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCheckStatus() {
        var image = isChosen ? SFSymbols.check : SFSymbols.circle
        circleImageView.image = image
    }
    
    private func initViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(circleImageView)
        circleImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.height.width.equalTo(20)
        }
        
        subView.addSubview(langLabel)
        langLabel.snp.makeConstraints { make in
            make.centerY.equalTo(circleImageView)
            make.leading.equalTo(circleImageView.snp.trailing).offset(10)
        }
        
        subView.addSubview(flagImageView)
        flagImageView.snp.makeConstraints { make in
            make.centerY.equalTo(circleImageView)
            make.trailing.equalToSuperview().offset(-20)
            make.height.width.equalTo(35)
        }
    }
    
    func setData(model: Language) {
        langLabel.text = model.name
        flagImageView.image = model.image
    }
    
}

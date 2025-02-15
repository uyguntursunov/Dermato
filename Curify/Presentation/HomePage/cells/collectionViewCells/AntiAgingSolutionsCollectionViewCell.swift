//
//  AntiAgingSolutionsCollectionViewCell.swift
//  Curify
//
//  
//

import UIKit

class AntiAgingSolutionsCollectionViewCell: UICollectionViewCell {
    
    lazy var subView = SubView(frame: .zero)
    lazy var titleLabel = Label(font: .systemFont(ofSize: 14, weight: .medium))
    
    lazy var imageView: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.width.equalTo(150)
        }
        
        subView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.equalTo(imageView)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func setData(imgString: String, title: String) {
        imageView.image = UIImage(named: imgString)
        titleLabel.text = title
    }
}

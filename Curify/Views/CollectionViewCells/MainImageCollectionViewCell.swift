//
//  MainImageCollectionViewCell.swift
//  Curify
//
//

import UIKit

class MainImagesCollectionViewCell: UICollectionViewCell {
    
    lazy var subView = SubView(frame: .zero)
    lazy var imageView = MainImageView(frame: .zero)
    
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
            make.edges.equalToSuperview()
        }
    }
    
    func setImage(url: String) {
        imageView.loadImage(with: url)
    }
}

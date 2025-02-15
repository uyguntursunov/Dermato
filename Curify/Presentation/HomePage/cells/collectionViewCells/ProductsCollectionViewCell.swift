//
//  ProductsCollectionViewCell.swift
//  Curify
//
//  
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    
    lazy var subView = SubView(frame: .zero)
    lazy var titleLabel = Label(font: .systemFont(ofSize: 14, weight: .medium))
    lazy var costTitleLabel = Label(font: .systemFont(ofSize: 14, weight: .heavy))
    lazy var sellerTitleLabel = Label(font: .systemFont(ofSize: 12, weight: .light))
    
    lazy var imageView: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.layer.cornerRadius = 8
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
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        subView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(160)
        }
        
        subView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.equalTo(imageView)
        }
        
        subView.addSubview(costTitleLabel)
        costTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(imageView)
        }
        
        subView.addSubview(sellerTitleLabel)
        sellerTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(costTitleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(imageView)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    func setData(product: Product) {
        imageView.image = UIImage(named: product.imgString)
        titleLabel.text = product.title
        costTitleLabel.text = product.cost
        sellerTitleLabel.text = product.seller
    }
}

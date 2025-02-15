//
//  TipsCollectionViewCell.swift
//  Curify
//
//

import UIKit

class TipsCollectionViewCell: UICollectionViewCell {
    
    lazy var subView = SubView(frame: .zero)
    
    lazy var imageView: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
    }
    
    func setData(imageString: String) {
        imageView.image = UIImage(named: imageString)
    }
}

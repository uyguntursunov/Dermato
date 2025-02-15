//
//  CameraButtonView.swift
//  Curify
//
//  
//

import UIKit

class CameraButtonView: UIView {
    
    lazy var cameraImageView: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.image = SFSymbols.camera
        imageView.tintColor = .white
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        backgroundColor = Colors.label
        addSubview(cameraImageView)
        cameraImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(35)
        }
    }
}

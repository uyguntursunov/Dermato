//
//  ActivityImageView.swift
//  Curify
//
//

import UIKit
import Kingfisher

class ActivityImageView: UIImageView {
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    private func initViews() {
        contentMode = .scaleAspectFit
        backgroundColor = .clear
        startLoading()
        
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    func loadImage(with url: String?) {
        let baseURL = ""
        if let imageURL = url, let url = URL(string: baseURL + imageURL) {
            kf.setImage(with: url) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let value):
                    self.image = value.image
                case .failure(let error):
                    print("Image loading error: ", error.localizedDescription)
                }
                self.stopLoading()
            }
        }
    }
    
    func setImage(image: UIImage?) {
        stopLoading()
        self.image = image
    }
}

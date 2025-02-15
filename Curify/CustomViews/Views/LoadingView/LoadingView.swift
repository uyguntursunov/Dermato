//
//  LoadingView.swift
//  Curify
//
//

import UIKit

class LoadingView: UIView {
    
    lazy var loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        indicator.startAnimating()
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
        return indicator
    }()
    
    lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.8
        blurEffectView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        return blurEffectView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        blurEffectView.frame = self.bounds
        insertSubview(blurEffectView, at: 0)
        loadingActivityIndicator.center = CGPoint(
            x: self.bounds.midX,
            y: self.bounds.midY
        )
        addSubview(loadingActivityIndicator)
    }
}

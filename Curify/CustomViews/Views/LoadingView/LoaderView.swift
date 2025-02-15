//
//  LoaderView.swift
//  Curify
//
//

import UIKit

class LoaderView: UIView {

    lazy var subView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.25)
        return view
    }()
    
    let spinningView = SpinnerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(spinningView)
        spinningView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

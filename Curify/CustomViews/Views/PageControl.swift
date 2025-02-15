//
//  PageControl.swift
//  Curify
//
//

import UIKit

class PageControl: UIPageControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        currentPage = 0
//        pageIndicatorTintColor = .secondaryLabel
//        currentPageIndicatorTintColor = .systemBackground
        hidesForSinglePage = true
    }
}

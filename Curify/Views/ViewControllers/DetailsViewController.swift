//
//  DetailsViewController.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 03/01/24.
//

import UIKit

class DetailsViewController: UIViewController {

    lazy var subView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Recommendations from doctors", "Personal program"])
        segmentedControl.titleForSegment(at: 0)
        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    private func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    

}

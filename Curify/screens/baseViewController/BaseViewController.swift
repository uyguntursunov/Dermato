//
//  BaseViewController.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 03/01/24.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    lazy var subView: UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubview()
    }
    
    func addSubview() {
        view.backgroundColor = .systemBackground
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

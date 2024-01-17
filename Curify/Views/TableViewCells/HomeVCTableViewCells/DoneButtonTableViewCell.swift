//
//  DoneButtonTableViewCell.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 04/01/24.
//

import UIKit

class DoneButtonTableViewCell: UITableViewCell {

    lazy var subView = SubView(frame: .zero)
    lazy var nextButton = Button(title: "Next")
    var isDoneButton: Bool = false
    weak var delegate: DrugContentViewControllerDelegate?
    var onButtonClick: ((UIButton)->())!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func doneButtonPressed() {
        if isDoneButton {
            
        } else {
            onButtonClick(UIButton())
            delegate?.nextButtonPressed()
        }
    }
    
    private func initViews() {
        nextButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(nextButton)
        nextButton.backgroundColor = Colors.label
        nextButton.layer.cornerRadius = 15
        nextButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(40)
        }
    }
    
}

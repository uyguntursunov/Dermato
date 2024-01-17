//
//  PersonalProgramTableViewCell.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 04/01/24.
//

import UIKit

class PersonalProgramTableViewCell: UITableViewCell {

    lazy var subView = SubView(frame: .zero)
    lazy var taskLabel = Label(font: UIFont.systemFont(ofSize: 20, weight: .medium))
    lazy var checkButton = Button(frame: .zero)
    weak var delegate: DetailsViewControllerDelegate?
    var isDone: Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        checkButton.addTarget(self, action: #selector(checkButtonPressed), for: .touchUpInside)
        
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(checkButton)
        checkButton.setImage(SFSymbols.circle, for: .normal)
        checkButton.layer.cornerRadius = 20
        checkButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.height.width.equalTo(40)
        }
        
        subView.addSubview(taskLabel)
        taskLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(checkButton.snp.trailing)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    @objc func checkButtonPressed() {
        delegate?.personalProgramCellSelected()
        if isDone {
            checkButton.setImage(SFSymbols.circle, for: .normal)
            taskLabel.textColor = Colors.label
            isDone = false
        }
        else {
            checkButton.setImage(SFSymbols.checkmark, for: .normal)
            taskLabel.textColor = Colors.tabBarUnselectedItem
            isDone = true
        }
    }
    
    func setData(task: String, isDone: Bool) {
        taskLabel.text = task
        self.isDone = isDone
    }
}

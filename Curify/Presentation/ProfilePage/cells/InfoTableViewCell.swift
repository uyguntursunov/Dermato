//
//  InfoTableViewCell.swift
//  Curify
//
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    lazy var subView = SubView(frame: .zero)
    lazy var infoLabel = Label(font: .systemFont(ofSize: 17, weight: .medium))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        
        subView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func setData(info: String) {
        infoLabel.text = info
    }
}

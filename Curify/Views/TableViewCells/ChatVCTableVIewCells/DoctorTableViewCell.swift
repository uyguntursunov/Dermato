//
//  DoctorTableViewCell.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 09/01/24.
//

import UIKit

class DoctorTableViewCell: UITableViewCell {

    lazy var subView = SubView(frame: .zero)
    lazy var mainImageView = MainImageView(frame: .zero)
    lazy var nameLabel = Label(font: .systemFont(ofSize: 20, weight: .bold))
    lazy var 
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

}

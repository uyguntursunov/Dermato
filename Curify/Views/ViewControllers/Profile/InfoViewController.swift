//
//  InfoViewController.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 07/01/24.
//

import UIKit

class InfoViewController: UIViewController {
    
    lazy var subView = SubView(frame: .zero)
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: String(describing: InfoTableViewCell.self))
        return tableView
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
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InfoTableViewCell.self), for: indexPath) as? InfoTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.setData(info: "Some info about our sponsors resources and doctors given in a beautiful way. Some logos and adds can be added. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sed sagittis nisi. Mauris id tortor quis urna congue lacinia. Suspendisse et libero finibus, iaculis enim a, egestas mauris. Sed vulputate, mauris vel tempor molestie, justo nisl interdum eros, id mollis ante nisi egestas velit. Sed id quam in risus volutpat molestie. Proin massa mi, volutpat vel elit id, vulputate aliquam tortor. Phasellus mi enim, porta non purus nec, mollis condimentum neque. Etiam pellentesque quam eu lacus sodales cursus. Vivamus ac egestas libero, eget euismod libero. Fusce vitae tellus eget dolor malesuada hendrerit nec in dui. Ut nec vulputate metus. Aliquam vel est quis elit tincidunt bibendum. Ut mi ipsum, dapibus ut neque non, condimentum convallis magna. Pellentesque mollis sit amet dolor sit amet consectetur.")
        return cell
    }
}

//
//  LogInViewController.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 07/01/24.
//

import UIKit

class LogInViewController: BaseViewController {

    lazy var subView = SubView(frame: .zero)
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(LogInTableViewCell.self, forCellReuseIdentifier: String(describing: LogInTableViewCell.self))
        tableView.register(DoneButtonTableViewCell.self, forCellReuseIdentifier: String(describing: DoneButtonTableViewCell.self))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
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

extension LogInViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LogInTableViewCell.self), for: indexPath) as? LogInTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DoneButtonTableViewCell.self), for: indexPath) as? DoneButtonTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.nextButton.setTitle("Continue with email", for: .normal)
            return cell
        }
    }
}


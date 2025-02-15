//
//  QuizViewController.swift
//  Dermato AI
//
//  
//

import UIKit

class QuizViewController: BaseViewController {

    lazy var subView = SubView(frame: .zero)
    
    lazy var headerView: QuizQuestionView = {
        let view = QuizQuestionView(frame: .zero)
        view.questionLabel.text = "In conclusion, what approach does the discussion addvocate towards fast food?"
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(QuizAnswerTableViewCell.self, forCellReuseIdentifier: String(describing: QuizAnswerTableViewCell.self))
        return tableView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 180)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        initViews()
    }
    
    private func initViews() {
//        title = "Question"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(headerView)
        tableView.tableHeaderView = headerView
    }

}

extension QuizViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QuizAnswerTableViewCell.self), for: indexPath) as? QuizAnswerTableViewCell else {return UITableViewCell()}
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

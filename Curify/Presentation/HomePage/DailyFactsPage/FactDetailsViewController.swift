//
//  FactDetailsViewController.swift
//  Dermato AI
//
//  
//

import UIKit

class FactDetailsViewController: BaseViewController {
    
    var facts: [FactModel] = []
    
    lazy var subView = SubView(frame: .zero)
    lazy var customBottomStartView: CustomBottomStartView = {
        let view = CustomBottomStartView(title: "Start Quiz")
        view.startButton.addTarget(self, action: #selector(didTapStartQuiz), for: .touchUpInside)
        return view
    }()
    
    lazy var headerImageView: MainImageView = {
        let imageView = MainImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(FactDetailsTableViewCell.self, forCellReuseIdentifier: String(describing: FactDetailsTableViewCell.self))
        return tableView
    }()
    
    @objc func didTapStartQuiz() {
//        let quizVC = QuizViewController()
//        quizVC.navigationItem.leftBarButtonItem = UIBarButtonItem(image: SFSymbols.back, style: .plain, target: self, action: #selector(backButtonTapped))
//        let navController = UINavigationController(rootViewController: quizVC)
//        navController.modalPresentationStyle = .fullScreen
//        self.navigationController?.show(navController, sender: self)
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerImageView.frame = CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width - 20, height: 200)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        initViews()
        getFacts()
    }
    
    func getFacts() {
        showLoadingView()
        API.shared.getFacts() { [weak self] result in
            self?.dismissLoadingView()
            switch result {
            case .success(let data):
                self?.facts = data
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func initViews() {
        title = "Fact for today"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(headerImageView)
        headerImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(200)
        }
        
        tableView.tableHeaderView = headerImageView
        
        subView.addSubview(customBottomStartView)
        customBottomStartView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(90)
        }
        
    }
    
}

extension FactDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FactDetailsTableViewCell.self), for: indexPath) as? FactDetailsTableViewCell else {return UITableViewCell()}
        
        if(facts.count != 0) {
            let fact = facts[0]
            headerImageView.loadImage(with: fact.image)
            cell.setData(model: FactModel(content: fact.content, id: fact.id, image: fact.image, number_of_question: fact.number_of_question, title: fact.title))
        }
        
        return cell
    }
}

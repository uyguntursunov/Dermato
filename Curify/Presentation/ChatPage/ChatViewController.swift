//
//  ChatViewController.swift
//  Curify
//
//

import UIKit

var chatTutorials: [Instruction] = [
    Instruction(title: "chatTutorial1".translate(), image: SFSymbols.questionmark!),
    Instruction(title: "chatTutorial2".translate(), image: SFSymbols.crossCase!),
    Instruction(title: "chatTutorial3".translate(), image: SFSymbols.stethoscope!),
    Instruction(title: "chatTutorial4".translate(), image: SFSymbols.book!)
]

class ChatViewController: BaseViewController {
    
    lazy var subView = SubView(frame: .zero)
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.register(CurifyChatTableViewCell.self, forCellReuseIdentifier: String(describing: CurifyChatTableViewCell.self))
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    lazy var startButton: Button = {
        let button = Button(title: "switchToConversation".translate())
        button.backgroundColor = Colors.label
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.navigationBar.sizeToFit()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc func startButtonPressed() {
        let chatVC = ChatPageViewController()
        let navigationController = UINavigationController(rootViewController: chatVC)
        navigationController.modalPresentationStyle = .fullScreen
        let backButton = UIBarButtonItem(image: SFSymbols.back, style: .plain, target: self, action: #selector(self.dismissViewController))
        backButton.tintColor = Colors.label
        chatVC.navigationItem.leftBarButtonItem = backButton
        self.present(navigationController, animated: true, completion: nil)
    }
    
    private func initViews() {
        title = "chat".translate()
        
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-100)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(50)
        }
    }
    
    @objc func dismissViewController() {
        self.dismiss(animated: true)
    }
    
    override func languageDidChange() {
        super.languageDidChange()
        title = "chat".translate()
        chatTutorials = [
            Instruction(title: "chatTutorial1".translate(), image: SFSymbols.questionmark!),
            Instruction(title: "chatTutorial2".translate(), image: SFSymbols.crossCase!),
            Instruction(title: "chatTutorial3".translate(), image: SFSymbols.stethoscope!),
            Instruction(title: "chatTutorial4".translate(), image: SFSymbols.book!)
        ]
        startButton.setTitle("switchToConversation".translate(), for: .normal)
        tableView.reloadData()
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatTutorials.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CurifyChatTableViewCell.self), for: indexPath) as? CurifyChatTableViewCell else { return UITableViewCell() }
        cell.setData(model: chatTutorials[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

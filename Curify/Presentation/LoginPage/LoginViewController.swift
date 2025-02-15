//
//  SignInViewController.swift
//  Curify
//
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func didTapLogin(username: String?, password: String?)
}

class LoginViewController: BaseViewController {
    
    var type: LoginType = .login {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var subView = SubView(frame: .zero)
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(LogInTableViewCell.self, forCellReuseIdentifier: String(describing: LogInTableViewCell.self))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        initViews()
        hideKeyboardWhenTappedAround()
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
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

extension LoginViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LogInTableViewCell.self), for: indexPath) as? LogInTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        return cell
    }
}

extension LoginViewController: LoginViewControllerDelegate {
    func didTapLogin(username: String?, password: String?) {
        if let username = username, username.replacingOccurrences(of: " ", with: "") != "", let password = password, password.replacingOccurrences(of: " ", with: "") != "" {
            showLoadingView()
            API.shared.login(username: username, password: password) { [weak self] result in
                switch result {
                case .success(let data):
                    UD.token = data.access_token
                    UD.username = username
                    self?.dismissLoadingView()
                    self?.setNewRootViewController()
                case.failure(let error):
                    print(error.localizedDescription)
                    self?.dismissLoadingView()
                    self?.showAlert(title: "Error", message: Alerts.loginFailed)
                }
            }
        }
    }
}

//
//  RegisterViewController.swift
//  Dermato AI
//
//  
//

import UIKit

protocol RegisterViewControllerDelegate: AnyObject {
    func didTapRegister(username: String?, email: String?, password: String?)
}

class RegisterViewController: BaseViewController {
    
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
        tableView.register(RegisterTableViewCell.self, forCellReuseIdentifier: String(describing: RegisterTableViewCell.self))
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

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RegisterTableViewCell.self), for: indexPath) as? RegisterTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        cell.setData(type: type)
        return cell
    }
}

extension RegisterViewController: RegisterViewControllerDelegate {
    func didTapRegister(username: String?, email: String?, password: String?) {
        if let password = password?.replacingOccurrences(of: " ", with: "") {
            if password.count < 6 {
                showAlert(title: "Error", message: Alerts.invalidPassword)
                return
            }
        }
        
        if let email = email?.replacingOccurrences(of: " ", with: "") {
            if !isValidEmail(email) {
                showAlert(title: "Error", message: Alerts.invalidEmail)
                return
            }
        }
        
        if let username = username, let email = email, let password = password {
            self.showLoadingView()
            
            API.shared.register(username: username, email: email, password: password) { [weak self] result in
                switch result {
                    //                case .success(_):
                    //                    API.shared.login(username: username, password: password) { [weak self] result in
                    //                        switch result {
                    //                        case .success(let data):
                    //                            UD.token = data.access_token
                    //                            UD.username = username
                    //                            self?.dismissLoadingView()
                    //                            self?.setNewRootViewController()
                    //                        case.failure(let error):
                    //                            print(error.localizedDescription)
                    //                            self?.dismissLoadingView()
                    //                            self?.showAlert(title: "Error", message: Alerts.wentWrong)
                    //                        }
                    //                    }
                    //                case .failure(_):
                    //                    self?.dismissLoadingView()
                    //                    self?.showAlert(title: "Error", message: Alerts.signUpFailure)
                    
                case .success(let data):
                    UD.token = data.message.access_token
                    UD.username = username
                    self?.dismissLoadingView()
                    self?.setNewRootViewController()
                case.failure(let error):
                    print(error.localizedDescription)
                    self?.dismissLoadingView()
                    self?.showAlert(title: "Error", message: Alerts.wentWrong)
                }
            }
//            self.dismissLoadingView()
        }
    }
}


//
//  SignInTableViewCell.swift
//  Curify
//
//

import UIKit

class LogInTableViewCell: UITableViewCell {

    lazy var subView = SubView(frame: .zero)
    lazy var titleLabel = Label(font: .systemFont(ofSize: 24, weight: .bold))
    lazy var usernameLabel = Label(font: .systemFont(ofSize: 17, weight: .medium))
    lazy var passwordLabel = Label(font: .systemFont(ofSize: 17, weight: .medium))
    lazy var usernmaeTextField = TextField(font: .systemFont(ofSize: 20, weight: .regular))
    lazy var passwordTextField = TextField(font: .systemFont(ofSize: 20, weight: .regular))
    
    lazy var loginButton: Button = {
        let button = Button(title: "Log in")
        button.backgroundColor = Colors.label
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: LoginViewControllerDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapLogin() {
        guard let username = usernmaeTextField.text, let password = passwordTextField.text else { return }
        delegate?.didTapLogin(username: username, password: password)
    }
    
    private func initViews() {
        
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(titleLabel)
        titleLabel.text = "Log in"
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        subView.addSubview(usernameLabel)
        usernameLabel.text = "Username"
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalTo(titleLabel)
        }
        
        subView.addSubview(usernmaeTextField)
        usernmaeTextField.placeholder = "Enter username"
        usernmaeTextField.layer.cornerRadius = 6
        usernmaeTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(5)
            make.leading.equalTo(usernameLabel)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        subView.addSubview(passwordLabel)
        passwordLabel.text = "Password"
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(usernmaeTextField.snp.bottom).offset(30)
            make.leading.equalTo(usernameLabel)
        }
        
        subView.addSubview(passwordTextField)
        passwordTextField.placeholder = "Enter password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.cornerRadius = 6
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(5)
            make.leading.equalTo(passwordLabel)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        subView.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.leading.trailing.equalTo(passwordTextField)
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
        }
    }
}

//
//  RegisterTableViewCell.swift
//  Dermato AI
//
//  
//

import UIKit

class RegisterTableViewCell: UITableViewCell {

    lazy var subView = SubView(frame: .zero)
    lazy var titleLabel = Label(font: .systemFont(ofSize: 24, weight: .bold))
    lazy var usernameLabel = Label(font: .systemFont(ofSize: 17, weight: .medium))
    lazy var emailLabel = Label(font: .systemFont(ofSize: 17, weight: .medium))
    lazy var passwordLabel = Label(font: .systemFont(ofSize: 17, weight: .medium))
    lazy var usernameTextField = TextField(font: .systemFont(ofSize: 20, weight: .regular))
    lazy var emailTextField = TextField(font: .systemFont(ofSize: 20, weight: .regular))
    lazy var passwordTextField = TextField(font: .systemFont(ofSize: 20, weight: .regular))
    
    lazy var registerButton: Button = {
        let button = Button(title: "Next")
        button.backgroundColor = Colors.label
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: RegisterViewControllerDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapRegister() {
        guard let username = usernameTextField.text, let email = emailTextField.text, let password = passwordTextField.text else { return }
        delegate?.didTapRegister(username: username, email: email, password: password)
    }
    
    private func initViews() {
        
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(titleLabel)
        titleLabel.text = "Register"
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        subView.addSubview(usernameLabel)
        usernameLabel.text = "Username"
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel)
        }
        
        subView.addSubview(usernameTextField)
        usernameTextField.placeholder = "Enter username"
        usernameTextField.layer.cornerRadius = 6
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(5)
            make.leading.equalTo(usernameLabel)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        subView.addSubview(emailLabel)
        emailLabel.text = "Email adress"
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel)
        }
        
        subView.addSubview(emailTextField)
        emailTextField.placeholder = "Enter email adress"
        emailTextField.layer.cornerRadius = 6
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(5)
            make.leading.equalTo(emailLabel)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        subView.addSubview(passwordLabel)
        passwordLabel.text = "Password"
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.equalTo(emailLabel)
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
        
        subView.addSubview(registerButton)
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.leading.trailing.equalTo(passwordTextField)
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
        }
    }
    
    func setData(type: LoginType) {
        
    }

}

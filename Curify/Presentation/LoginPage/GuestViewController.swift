//
//  LogInViewController.swift
//  Curify
//
//

import UIKit

class GuestViewController: UIViewController {
    
    var vc: UIViewController = UIViewController()
    
    var height = UIScreen.main.bounds.height - 100
    var width = (UIScreen.main.bounds.width - 50) / 2
    
    lazy var subView = SubView(frame: .zero)
    
    lazy var backgroundImageView: ImageView = {
        let imageView = ImageView (frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.image = Images.loginPage
        return imageView
    }()
    
    lazy var logoImageView: ImageView = {
        let imageView = ImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.image = Images.curify
        return imageView
    }()
    
    lazy var titleLabel: Label = {
        let label = Label(font: .systemFont(ofSize: 36, weight: .semibold))
        label.text = "Dermato AI"
        label.textColor = .black
        return label
    }()
    
    lazy var loginButton: Button = {
        let button = Button(title: "Login")
        button.backgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didPressLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var registerButton: Button = {
        let button = Button(title: "Register")
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didPressRegister), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    }
    
    override func viewDidLayoutSubviews() {
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: height)
    }
    
    @objc func didPressLogin() {
        goNextPage(type: .login)
    }
    
    @objc func didPressRegister() {
        goNextPage(type: .register)
    }
    
    private func goNextPage(type: LoginType) {
        switch type {
        case .login:
            vc = LoginViewController()
        case .register:
            vc = RegisterViewController()
        }
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        let backButton = UIBarButtonItem(image: SFSymbols.back, style: .plain, target: self, action: #selector(dismissVC))
        backButton.tintColor = Colors.label
        vc.navigationItem.leftBarButtonItem = backButton
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func dismissVC() {
        self.dismiss(animated: true)
    }
    
    private func initViews() {
        
        view.backgroundColor = .white
        view.addSubview(backgroundImageView)
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-50)
            make.leading.equalToSuperview().offset(50)
            make.height.width.equalTo(100)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.leading.equalTo(logoImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-50)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(width)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.centerY.equalTo(loginButton)
            make.leading.equalTo(loginButton.snp.trailing).offset(10)
            make.width.equalTo(width)
            make.height.equalTo(50)
        }
    }
}


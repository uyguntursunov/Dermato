//
//  PersonalInfoViewController.swift
//  Curify
//
//  
//

import UIKit

class PersonalInfoViewController: BaseViewController {
    
    var userData: UserModel?
    var isChanged: Bool = false
    
    var gender: String = "" {
        didSet {
            reloadRow(at: 3)
            isChanged = true
        }
    }
    
    var userInfo: [String: String] = ["Name": "", "Email": ""]
    
    let details: [Instruction] = [
        Instruction(title: "name".translate(), image: SFSymbols.person!),
        Instruction(title: "email".translate(), image: SFSymbols.email!),
        Instruction(title: "dateOfBirth".translate(), image: SFSymbols.calendar!),
        Instruction(title: "gender".translate(), image: SFSymbols.people!),
        Instruction(title: "deleteAccount".translate(), image: SFSymbols.trash!)
    ]
    
    lazy var subView = SubView(frame: .zero)
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.register(PersonalInfoTableViewCell.self, forCellReuseIdentifier: String(describing: PersonalInfoTableViewCell.self))
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        
        showUserInfo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if self.isMovingFromParent {
            print("xxx", userInfo)
            if isChanged {
                updateUserInfo(model: UserModel(Id: 1, firstname: "Xxx", lastname: "", skin_color: 1, skin_type: 1, gender: "", date: ""))
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    }
    
    func showUserInfo() {
        API.shared.showUserInfo { [weak self] result in
            switch result {
            case .success(let data):
                self?.userData = data
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateUserInfo(model: UserModel) {
        print("mmm", model)
        API.shared.fillUserInfo(model: model) { result in
            switch result {
            case .success(_):
                print("User info updated successfully")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func showDeletionAlert() {
        let alertController = UIAlertController(title: "deleteAccount".translate(), message: "deleteAccountConfirmation".translate(), preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "delete".translate(), style: .destructive) { (action) in
            self.showLoadingView()
            API.shared.deleteUser { [weak self] result in
                switch result {
                case .success(_):
                    UD.token = ""
                    self?.dismissLoadingView()
                case .failure(_):
                    self?.dismissLoadingView()
                    self?.showAlert(title: "error".translate(), message: Alerts.deletionFailure)
                }
            }
            self.dismissLoadingView()
        }
        let cancelAction = UIAlertAction(title: "cancel".translate(), style: .cancel) { (action) in
        }
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func languageDidChange() {
        title = "personalInfo".translate()
    }
    
    func reloadRow(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private func initViews() {
        title = "personalInfo".translate()
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func showGenderAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "male".translate(), style: .default, handler: { [weak self] (action: UIAlertAction) in
            self?.gender = "male".translate()
        }))
        alert.addAction(UIAlertAction(title: "female".translate(), style: .default, handler: { [weak self] (action: UIAlertAction) in
            self?.gender = "female".translate()
        }))
        alert.addAction(UIAlertAction(title: "cancel".translate(), style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

extension PersonalInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PersonalInfoTableViewCell.self), for: indexPath) as? PersonalInfoTableViewCell else { return UITableViewCell() }
        cell.configure(model: details[indexPath.row])
        switch indexPath.row {
        case 0:
            cell.isName = true
            cell.textField.text = userData?.firstname ?? ""
            cell.textChanged = { [weak self] text in
                self?.userInfo["Name"] = text
                self?.isChanged = true
            }
        case 1:
            cell.isName = true
            cell.textField.text = userData?.firstname ?? ""
            cell.textChanged = { [weak self] text in
                self?.userInfo["Email"] = text
                self?.isChanged = true
            }
        case 2:
            cell.isDate = true
        case 3:
            cell.isGender = true
            cell.genderNameLabel.text = gender
            cell.selectionStyle = .default
        case 4:
            cell.isGender = true
            cell.selectionStyle = .default
        default:
            break
        }
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 3 {
            showGenderAlert()
        } else if indexPath.row == 4 {
            showDeletionAlert()
        }
    }
}

//
//  HealthDetailsViewController.swift
//  Curify
//
//  Created by Uyg'un Tursunov on 05/01/24.
//

import UIKit

class HealthDetailsViewController: BaseViewController {
    
    var properties = ["Name", "Age", "Sex", "Height(cm)", "Weight(kg)", "Waist(cm)"]
    lazy var subView = SubView(frame: .zero)
    lazy var deleteAccountButton = Button(title: "Delete Accont")
    let userViewModel = UserViewModel()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ProfileHeaderTableViewCell.self, forCellReuseIdentifier: String(describing: ProfileHeaderTableViewCell.self))
        tableView.register(HealthDetailsTableViewCell.self, forCellReuseIdentifier: String(describing: HealthDetailsTableViewCell.self))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        initViews()
    }
    
    @objc func doneButtonPressed() {
        let model = UserInfoModel.self
        userViewModel.fillUserInfo(model: UserModel(name: model.name ?? "", age: model.age ?? 1, sex: model.sex ?? "", height: model.height ?? "", weight: model.weight ?? "", waist: model.waist ?? ""))
        dismiss(animated: true)
    }
    
    @objc func deleteAccountBtnPressed() {
        let alertController = UIAlertController(title: "Delete account", message: Alerts.deleteAccount, preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                self.showLoadingView()
                API.shared.deleteUser { [weak self] result in
                    switch result {
                    case .success(_):
                        UD.token = ""
                        self?.dissmissLoadingView()
                    case .failure(_):
                        self?.dissmissLoadingView()
                        self?.showAlert(title: "Error", message: Alerts.deletionFailure)
                    }
                }
                self.dissmissLoadingView()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            }
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
    }
    
    private func initViews() {
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonPressed))
        doneButton.tintColor = Colors.label
        navigationItem.rightBarButtonItem = doneButton
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(deleteAccountButton)
        deleteAccountButton.addTarget(self, action: #selector(deleteAccountBtnPressed), for: .touchUpInside)
        deleteAccountButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }
}

extension HealthDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileHeaderTableViewCell.self), for: indexPath) as? ProfileHeaderTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.setData(name: "Username")
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HealthDetailsTableViewCell.self), for: indexPath) as? HealthDetailsTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.setData(title: properties[indexPath.row - 1])
            cell.detailTextField.delegate = self
            return cell
        }
    }
}

extension HealthDetailsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let point = textField.convert(CGPoint.zero, to: tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        if let indexPath = indexPath {
            switch indexPath.row {
            case 1:
                if let name = textField.text {
                    UserInfoModel.name = name
                }
            case 2:
                if let text = textField.text, let age = Int(text) {
                    UserInfoModel.age = age
                }
            case 3:
                if let sex = textField.text {
                    UserInfoModel.sex = sex
                }
            case 4:
                if let height = textField.text {
                    UserInfoModel.height = height
                }
            case 5:
                if let weight = textField.text {
                    UserInfoModel.weight = weight
                }
            case 6:
                if let waist = textField.text {
                    UserInfoModel.waist = waist
                }
            default:
                break
            }
        }
    }
}

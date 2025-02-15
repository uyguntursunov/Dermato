//
//  ProfileViewController.swift
//  Curify
//
//

import UIKit
import StoreKit

var profileMenus: [Instruction] = [
    Instruction(title: "personalInfo".translate(), image: SFSymbols.profile!),
    Instruction(title: "history".translate(), image: SFSymbols.clock!),
    Instruction(title: "language".translate(), image: SFSymbols.lang!),
    Instruction(title: "rateApp".translate(), image: SFSymbols.star!),
    Instruction(title: "termsOfUse".translate(), image: SFSymbols.question!),
    //    Instruction(title: "infoAboutApp".translate(), image: SFSymbols.about!),
    Instruction(title: "signOut".translate(), image: SFSymbols.logOut!)
]

class ProfileViewController: BaseViewController {
    
    lazy var subView = SubView(frame: .zero)
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(ProfileMenusTableViewCell.self, forCellReuseIdentifier: String(describing: ProfileMenusTableViewCell.self))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        initViews()
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    private func initViews() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "profile".translate()
        
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func languageDidChange() {
        title = "profile".translate()
        profileMenus = [
            Instruction(title: "personalInfo".translate(), image: SFSymbols.profile!),
            Instruction(title: "history".translate(), image: SFSymbols.clock!),
            Instruction(title: "language".translate(), image: SFSymbols.lang!),
            Instruction(title: "rateApp".translate(), image: SFSymbols.star!),
            Instruction(title: "termsOfUse".translate(), image: SFSymbols.question!),
            //            Instruction(title: "infoAboutApp".translate(), image: SFSymbols.about!),
            Instruction(title: "signOut".translate(), image: SFSymbols.logOut!),
        ]
        tableView.reloadData()
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileMenus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileMenusTableViewCell.self), for: indexPath) as? ProfileMenusTableViewCell else { return UITableViewCell() }
        cell.setData(model: profileMenus[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var vc: UIViewController?
        
        switch indexPath.row {
        case 0:
            vc = PersonalInfoViewController()
        case 1:
            vc = ScansHistoryViewController()
        case 2:
            let panModalVC = ChangeLangViewController()
            self.presentPanModal(panModalVC)
        case 3:
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "appId") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        case 4:
            vc = TestViewController()
//            vc = InfoViewController()
        case 5:
            let alertController = UIAlertController(title: "signOut".translate(), message: "signOutAlert".translate(), preferredStyle: .alert)
            let logoutAction = UIAlertAction(title: "signOut".translate(), style: .destructive) { (action) in
                UD.token = ""
                UD.email = ""
                self.goSigninPage()
            }
            let cancelAction = UIAlertAction(title: "cancel".translate(), style: .cancel, handler: nil)
            alertController.addAction(logoutAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        default:
            break
        }
        
        guard let vc = vc else { return }
        navigationController?.pushViewController(vc, animated: true)
        
        //        guard let vc = vc else { return }
        //        let navigationController = UINavigationController(rootViewController: vc)
        //        let backButton = UIBarButtonItem(image: SFSymbols.back, style: .plain, target: self, action: #selector(dismissViewController))
        //        backButton.tintColor = Colors.label
        //        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissViewController))
        //        doneButton.tintColor = Colors.label
        //        vc.navigationItem.leftBarButtonItem = backButton
        //        //        vc.navigationItem.rightBarButtonItem = doneButton
        //        self.present(navigationController, animated: true, completion: nil)
    }
}

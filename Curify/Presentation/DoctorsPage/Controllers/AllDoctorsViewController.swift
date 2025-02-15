//
//  AllDoctorsViewController.swift
//  Curify
//
//

import UIKit

class AllDoctorsViewController: BaseViewController {
    
    var doctors = [DoctorModel]() {
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
        tableView.register(AllDoctorsTableViewCell.self, forCellReuseIdentifier: String(describing: AllDoctorsTableViewCell.self))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        initViews()
    }
    
    private func initViews() {
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(subView)
        subView.backgroundColor = .secondarySystemBackground
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func dismissViewController() {
        self.dismiss(animated: true)
    }
}

extension AllDoctorsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AllDoctorsTableViewCell.self), for: indexPath) as? AllDoctorsTableViewCell else { return UITableViewCell() }
        cell.setData(model: doctors[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DoctorDetailsViewController()
        vc.title = doctors[indexPath.row].name
        vc.doctorModel = doctors[indexPath.row]
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.modalPresentationStyle = .fullScreen
        let backButton = UIBarButtonItem(image: SFSymbols.back, style: .plain, target: self, action: #selector(dismissViewController))
        backButton.tintColor = Colors.label
        vc.navigationItem.leftBarButtonItem = backButton
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}

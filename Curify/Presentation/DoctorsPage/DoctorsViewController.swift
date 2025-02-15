//
//  DoctorsViewController.swift
//  Curify
//
//  
//

import UIKit

protocol DoctorsViewControllerDelegate: AnyObject {
    func didSelectDoctor(model: DoctorModel)
    func allButtonPressed(section: Int)
}

class DoctorsViewController: BaseViewController {
    
    var doctors = [DoctorTypeModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var subView = SubView(frame: .zero)
    var loadedSuccessfully: Bool = false
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: AllDoctorsViewController())
        searchController.searchBar.placeholder = "Search for a doctor"
        searchController.searchBar.searchBarStyle = .minimal
        return searchController
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DoctorsTableViewCell.self, forCellReuseIdentifier: String(describing: DoctorsTableViewCell.self))
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        initViews()
        getDoctors()
    }
    
    func getDoctors() {
        showLoadingView()
        API.shared.getDoctors() { [weak self] result in
            self?.dismissLoadingView()
            switch result {
            case .success(let data):
                self?.doctors = data
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func initViews() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Doctors"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        
        definesPresentationContext = true
        
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
        dismiss(animated: true)
    }
}

extension DoctorsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return doctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DoctorsTableViewCell.self), for: indexPath) as? DoctorsTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        if let doctors = self.doctors[indexPath.section].Doctor {
            cell.doctors = doctors
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = SectionHeaderView(frame: .zero)
        sectionHeaderView.doctorDelegate = self
        sectionHeaderView.allButton.backgroundColor = .systemBackground
        sectionHeaderView.doctorDelegate = self
        sectionHeaderView.section = section
        sectionHeaderView.setData(title: doctors[section].type ?? "")
        return sectionHeaderView
    }
}

extension DoctorsViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text, !query.isEmpty,
              let resultsController = searchController.searchResultsController as? AllDoctorsViewController else { return }
        //        showLoadingView()
        API.shared.searchDoctor(query: query) { [weak self] result in
            switch result {
            case .success(let data):
                self?.loadedSuccessfully = true
                resultsController.doctors = data
                DispatchQueue.main.async {
                    resultsController.tableView.reloadData()
                }
            case .failure(let error):
                self?.loadedSuccessfully = false
                resultsController.doctors = []
                print(error)
            }
        }
    }
}

extension DoctorsViewController: DoctorsViewControllerDelegate {
    func didSelectDoctor(model: DoctorModel) {
        let vc = DoctorDetailsViewController()
        vc.title = model.name
        vc.doctorModel = model
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.modalPresentationStyle = .fullScreen
        let backButton = UIBarButtonItem(image: SFSymbols.back, style: .plain, target: self, action: #selector(dismissViewController))
        backButton.tintColor = Colors.label
        vc.navigationItem.leftBarButtonItem = backButton
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func allButtonPressed(section: Int) {
        let vc = AllDoctorsViewController()
        if let doctors = doctors[section].Doctor, let type = self.doctors[section].type {
            vc.title = type
            vc.doctors = doctors
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

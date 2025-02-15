//
//  ScansHistoryViewController.swift
//  Curify
//
//  
//

import UIKit

class ScansHistoryViewController: BaseViewController {
    
    var scans: [ScanItem] = [] {
        didSet {
            noScansLabel.isHidden = !scans.isEmpty
            DispatchQueue.main.async { [weak self]  in
                self?.tableView.reloadData()
            }
        }
    }

    lazy var subView = SubView(frame: .zero)
    
    lazy var noScansLabel: Label = {
       let label = Label(font: .systemFont(ofSize: 17, weight: .medium))
        label.text = "noScans".translate()
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ScansHistoryTableViewCell.self, forCellReuseIdentifier: String(describing: ScansHistoryTableViewCell.self))
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        fetchScans()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        initViews()
    }
    
    func fetchScans() {
        showLoadingView()
        DataPersistanceManager.shared.fetchScanFromDatabase { [weak self] result in
            self?.dismissLoadingView()
            switch result {
            case .success(let data):
                self?.scans = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteScan(model: ScanItem, indexPathRow: Int) {
        showLoadingView()
        DataPersistanceManager.shared.deleteScan(model: model) { [weak self] result in
            self?.dismissLoadingView()
            switch result {
            case .success(()):
                self?.scans.remove(at: indexPathRow)
                print("Successfully deleted")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func initViews() {
        title = "history".translate()
        
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(noScansLabel)
        noScansLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    override func languageDidChange() {
        title = "history".translate()
        noScansLabel.text = "noScans".translate()
        tableView.reloadData()
    }

}

extension ScansHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        scans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ScansHistoryTableViewCell.self), for: indexPath) as? ScansHistoryTableViewCell else { return UITableViewCell() }
        cell.setData(model: scans[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let scan = scans[indexPath.row]
            deleteScan(model: scan, indexPathRow: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            break
        }
    }
    
}

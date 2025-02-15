//
//  DetailsViewController.swift
//  Curify
//
//

import UIKit

protocol DetailsViewControllerDelegate: AnyObject {
    func personalProgramCellSelected()
}

class DetailsViewController: BaseViewController {
    
    var personalPrograms = ["Cardiovascular exercises", "Flexibility and Balance Exercises", "Walking", "Deadlifts"]
    lazy var subView = SubView(frame: .zero)
    var isRecommendation: Bool = true
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Recommendations", "Personal program"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = Colors.label
        let attributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
        ]
        segmentedControl.setTitleTextAttributes(attributes, for: .normal)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        initViews()
    }
    
    @objc func segmentedControlValueChanged() {
        navigationController?.navigationBar.prefersLargeTitles = false
        updateTableView()
    }
    
    func updateTableView() {
        isRecommendation = segmentedControl.selectedSegmentIndex == 0
        tableView.showsVerticalScrollIndicator = segmentedControl.selectedSegmentIndex == 0
        tableView.reloadData()
    }
    
    private func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

//
//  DoctorDetailsViewController.swift
//  Curify
//
//  
//

import UIKit

protocol DoctorDetailsViewControllerDelegate: AnyObject {
    func scheduleButtonPressed()
}

class DoctorDetailsViewController: BaseViewController {
    
    let width = UIScreen.main.bounds.width
    var doctorModel: DoctorModel?
    
    lazy var subView = SubView(frame: .zero)
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.tableHeaderView = collectionView
        tableView.register(DoctorDetailsTableViewCell.self, forCellReuseIdentifier: String(describing: DoctorDetailsTableViewCell.self))
        return tableView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: width, height: 200), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        collectionView.register(MainImagesCollectionViewCell.self, forCellWithReuseIdentifier: String.init(describing: MainImagesCollectionViewCell.self))
        return collectionView
    }()
    
    lazy var pageControl: PageControl = {
        let pageControl = PageControl(frame: .zero)
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        initViews()
    }
    
    private func initViews() {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(collectionView.snp.bottom).offset(-5)
        }
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
}

extension DoctorDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DoctorDetailsTableViewCell.self), for: indexPath) as? DoctorDetailsTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        if let model = doctorModel {
            cell.setData(model: model)
        }
        return cell
    }
}

extension DoctorDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MainImagesCollectionViewCell.self), for: indexPath) as? MainImagesCollectionViewCell else { return UICollectionViewCell() }
        if let imageURL = doctorModel?.photo {
            cell.setImage(url: imageURL)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width, height: 220)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = currentPage
    }
}

extension DoctorDetailsViewController: DoctorDetailsViewControllerDelegate {
    func scheduleButtonPressed() {
        let vc = ScheduleViewController()
        vc.doctorModel = doctorModel
        navigationController?.pushViewController(vc, animated: true)
//        let navigationController = UINavigationController(rootViewController: vc)
//        let backButton = UIBarButtonItem(image: SFSymbols.back, style: .plain, target: self, action: #selector(dismissViewController))
//        backButton.tintColor = Colors.label
//        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonPressed))
//        doneButton.tintColor = Colors.label
//        vc.navigationItem.leftBarButtonItem = backButton
//        vc.navigationItem.rightBarButtonItem = doneButton
//        vc.title = "Enter the details"
//        self.present(navigationController, animated: true, completion: nil)
    }
}

//
//  HomeViewController.swift
//  Curify
//
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didSelectNews(urlString: String)
}

class HomeViewController: BaseViewController {
    
    var news: NewsModel?
    let sectionTitles = ["Daily Facts", "Skin Care Products", "News", "Anti-Aging Solutions"]
    let tips = ["tip1", "tip2", "tip3"]
    let width = UIScreen.main.bounds.width
    var currentPage = 1
    var totalPages = 1
    
    lazy var subView = SubView(frame: .zero)
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.refreshControl = refreshControl
        tableView.register(HomeSectionsTableViewCell.self, forCellReuseIdentifier: String(describing: HomeSectionsTableViewCell.self))
        tableView.register(ProductsTableViewCell.self, forCellReuseIdentifier: String(describing: ProductsTableViewCell.self))
        tableView.register(AntiAgingSolutionsTableViewCell.self, forCellReuseIdentifier: String(describing: AntiAgingSolutionsTableViewCell.self))
        return tableView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: width - 20, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumLineSpacing = 0
        //        layout.minimumInteritemSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(TipsCollectionViewCell.self, forCellWithReuseIdentifier: String.init(describing: TipsCollectionViewCell.self))
        return collectionView
    }()
    
    lazy var pageControl: PageControl = {
        let pageControl = PageControl(frame: .zero)
        pageControl.numberOfPages = tips.count
        return pageControl
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadNews), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        initViews()
        //        getNews(page: currentPage)
    }
    
    override func viewDidLayoutSubviews() {
        collectionView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 180)
    }
    
    @objc func loadNews() {
        refreshControl.endRefreshing()
    }
    
    private func initViews() {
        title = "home".translate()
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(collectionView)
        tableView.tableHeaderView = collectionView
        
        subView.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(collectionView.snp.bottom).offset(-5)
        }
    }
    
    func convertedDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if let inputDate = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "MMMM dd, yyyy"
            let outputDateString = dateFormatter.string(from: inputDate)
            return outputDateString
        } else {
            return ""
        }
    }
    
    func showWebView(urlString: String) {
        let vc = WebViewController()
        vc.urlString = urlString
        let navigationController = UINavigationController(rootViewController: vc)
        let backButton = UIBarButtonItem(image: SFSymbols.back, style: .plain, target: self, action: #selector(dismissViewController))
        backButton.tintColor = Colors.label
        navigationController.navigationItem.leftBarButtonItem = backButton
        present(navigationController, animated: true)
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    override func languageDidChange() {
        title = "home".translate()
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        //        return news?.News?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeSectionsTableViewCell.self), for: indexPath) as? HomeSectionsTableViewCell else { return UITableViewCell() }
            //        cell.delegate = self
            //        let news = news?.News?[indexPath.row]
            //        cell.setData(model: News(id: news?.id, title: news?.title, body: news?.body, owner: news?.owner, photo: news?.photo, created_at: convertedDate(date: news?.created_at ?? "26.01.2024")))
            cell.setData(type: .dailyFact)
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductsTableViewCell.self), for: indexPath) as? ProductsTableViewCell else { return UITableViewCell() }
            cell.setData(numberOfItems: 4)
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeSectionsTableViewCell.self), for: indexPath) as? HomeSectionsTableViewCell else { return UITableViewCell() }
            //        cell.delegate = self
            //        let news = news?.News?[indexPath.row]
            //        cell.setData(model: News(id: news?.id, title: news?.title, body: news?.body, owner: news?.owner, photo: news?.photo, created_at: convertedDate(date: news?.created_at ?? "26.01.2024")))
            cell.setData(type: .news)
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AntiAgingSolutionsTableViewCell.self), for: indexPath) as? AntiAgingSolutionsTableViewCell else { return UITableViewCell() }
            cell.setData(numberOfItems: 4)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var vc: UIViewController?
        
        switch indexPath.section {
        case 0:
            let factDetailsVC = FactDetailsViewController()
            factDetailsVC.navigationItem.leftBarButtonItem = UIBarButtonItem(image: SFSymbols.back, style: .plain, target: self, action: #selector(backButtonTapped))
            let navController = UINavigationController(rootViewController: factDetailsVC)
            navController.modalPresentationStyle = .fullScreen
            self.navigationController?.show(navController, sender: self)
            
        case 1:
            vc = ProductsViewController()
            
        case 2:
            vc = NewsViewController()
            
        case 3:
            break
            
        default:
            break
        }
        
        guard let vc = vc else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    //        guard let header = view as? UITableViewHeaderFooterView else { return }
    //        header.textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
    ////        header.textLabel?.frame = CGRect(x: view.bounds.origin.x + 20, y: view.bounds.origin.y, width: 100, height: view.bounds.height)
    //        header.textLabel?.textColor = .label
    //        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    //    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = SectionHeaderTitleView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        sectionHeaderView.setData(title: sectionTitles[section])
        return sectionHeaderView
    }
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return sectionTitles[section]
    //    }
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //        if let news = news?.News?.count {
    //            if indexPath.row == news - 1, currentPage < totalPages {
    //                getNews(page: currentPage)
    //                currentPage += 1
    //            }
    //        }
    //    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30 // Setting header height to 0
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: TipsCollectionViewCell.self), for: indexPath) as? TipsCollectionViewCell else { return UICollectionViewCell() }
        cell.setData(imageString: tips[indexPath.section])
        return cell
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        return CGSize(width: width, height: 250)
    //    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = currentPage
    }
}

extension HomeViewController: HomeViewControllerDelegate {
    func didSelectNews(urlString: String) {
        showWebView(urlString: urlString)
    }
}

//
//  NewsViewController.swift
//  Curify
//
//  
//

import UIKit

protocol NewsViewControllerDelegate: AnyObject {
    func didSelectNews(urlString: String)
}

class NewsViewController: BaseViewController {
    
    var news: NewsModel?
    var currentPage = 1
    var totalPages = 1
    
    lazy var subView = SubView(frame: .zero)
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: String(describing: NewsTableViewCell.self))
        return tableView
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
        getNews(page: currentPage)
    }
    
    @objc func loadNews() {
        refreshControl.endRefreshing()
    }
    
    func getNews(page: Int) {
        showLoadingView()
        API.shared.getNews(page: page) { [weak self] result in
            self?.dismissLoadingView()
            switch result {
            case .success(let data):
                self?.news = data
//                self?.totalPages = data.total_pages ?? 1
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func initViews() {
        title = "news".translate()
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func convertedDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
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
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: SFSymbols.back, style: .plain, target: self, action: #selector(dismissViewController))
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .popover
        self.navigationController?.show(navController, sender: self)
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    override func languageDidChange() {
        title = "home".translate()
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsTableViewCell.self), for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        let news = news?.data?[indexPath.row]
        cell.setData(model: News(id: news?.id, category_id: news?.category_id, date: convertedDate(date: news?.date ?? ""), title: news?.title, anons: news?.anons, views: news?.views, anons_image: news?.anons_image, url_to_web: news?.url_to_web))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let urlString = news?.data?[indexPath.row].url_to_web else { return }
        showWebView(urlString: urlString)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let news = news?.data?.count {
            if indexPath.row == news - 1, currentPage < totalPages {
                getNews(page: currentPage)
                currentPage += 1
            }
        }
    }
}

extension NewsViewController: NewsViewControllerDelegate {
    func didSelectNews(urlString: String) {
        showWebView(urlString: urlString)
    }
}


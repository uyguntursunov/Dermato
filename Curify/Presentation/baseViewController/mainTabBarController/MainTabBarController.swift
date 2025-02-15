//
//  ViewController.swift
//  Curify
//
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let nc1 = UINavigationController(rootViewController: HomeViewController())
    let nc2 = UINavigationController(rootViewController: ImgScannerViewController())
    let nc3 = UINavigationController(rootViewController: ChatViewController())
    let nc4 = UINavigationController(rootViewController: ProfileViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        setTitles()
        setTabBarItemImages()
        
        setViewControllers([nc1, nc2, nc3, nc4], animated: true)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("ChangeTabBar"), object: nil, queue: nil) { [weak self] _ in
            self?.nc1.title = Titles.home
            self?.nc2.title = Titles.scanner
            self?.nc3.title = Titles.chat
            self?.nc4.title = Titles.profile
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    
    private func initViews() {
        tabBar.backgroundColor = .systemBackground
        
        tabBar.tintColor = Colors.label
        tabBar.unselectedItemTintColor = .systemGray
        
        tabBar.isTranslucent = false
        tabBar.clipsToBounds = false
        
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        lineView.backgroundColor = UIColor.systemGray5
        tabBar.addSubview(lineView)
    }
    
    private func setTitles() {
        nc1.title = Titles.home
        nc2.title = Titles.scanner
        nc3.title = Titles.chat
        nc4.title = Titles.profile
    }
    
    private func setTabBarItemImages() {
        nc1.tabBarItem.image = SFSymbols.home
        nc2.tabBarItem.image = SFSymbols.cameraFill
        nc3.tabBarItem.image = SFSymbols.chat
        nc4.tabBarItem.image = SFSymbols.profile
    }
    
}


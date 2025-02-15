//
//  BaseViewController.swift
//  Curify
//
//

import UIKit
import SnapKit

extension Notification.Name {
    static let languageDidChange = Notification.Name("LanguageDidChange")
}

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: .languageDidChange, object: nil)
    }
    
    func getCurrentLanguage() -> String {
        let lang = LanguageManager.getAppLang()
        return lang == .English ? "en" : "uz"
    }
    
    @objc func languageDidChange() { }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .languageDidChange, object: nil)
    }
    
    func configure() {
        view.backgroundColor = .systemBackground
        
//        if let navigationBar = navigationController?.navigationBar {
//            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.label]
//            navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.label]
//            navigationBar.tintColor = Colors.label
//        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
}

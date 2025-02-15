//
//  WebViewController.swift
//  Curify
//
//  
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    var urlString: String?
    
    private lazy var webView: WKWebView = {
        let view = WKWebView()
        view.navigationDelegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = webView
        if let urlString = urlString {
            guard let url = URL(string: urlString) else { return }
            webView.load(URLRequest(url: url))
        }
    }
}

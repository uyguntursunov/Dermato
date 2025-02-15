//
//  Ext+ViewController.swift
//  Curify
//
//

import UIKit

fileprivate var loaderView: LoaderView!
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            completion?()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func setNewRootViewController() {
        let newRootViewController = MainTabBarController()
        if let sceneDelegate = SceneDelegate.shared {
            sceneDelegate.window?.rootViewController = newRootViewController
        }
    }
    
    func goSigninPage() {
        let newRootViewController = GuestViewController()
        if let sceneDelegate = SceneDelegate.shared {
            sceneDelegate.window?.rootViewController = newRootViewController
        }
    }
    
    func showLoadingView(){
        loaderView = LoaderView(frame: view.bounds)
        view.addSubview(loaderView)
        loaderView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            loaderView.alpha = 1
        }, completion: nil)
    }
    
    func dismissLoadingView(){
        guard let loaderView = loaderView else {
            return
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            DispatchQueue.main.async {
                loaderView.alpha = 0
            }
        }) { _ in
            loaderView.removeFromSuperview()
        }
    }
    
    func getBottomMargin() -> CGFloat{
        let window = UIApplication.shared.keyWindow
        if let bottomPadding = window?.safeAreaInsets.bottom{
            return bottomPadding
        }
        return 0
    }
}



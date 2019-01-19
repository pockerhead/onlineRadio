//  DealApp
//
//  Created by Egor Sakhabaev on 11.04.2018.
//  Copyright © 2018 Egor Sakhabaev. All rights reserved.
//
import UIKit
//import SideMenuSwift
//import SwiftEntryKit
extension UIViewController {
    
    func setStatusBarBackgroundColor(color: UIColor) {
        
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        
        statusBar.backgroundColor = color
    }
    func endEditing() {
        self.view.endEditing(true)
    }
    
    func animatableUpdateStatusBarAppearance() {
        UIView.animate(withDuration: 0.3) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
}

extension UIViewController {
    
    var isRootVC: Bool {
        return navigationController?.viewControllers.count == 1
    }
    
    var isModal: Bool {
        if self.presentingViewController != nil && (self.presentingViewController as? NotModalViewController) == nil {
            return true
        }
        if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController {
            return true
        }
        if let state = self.tabBarController?.presentingViewController?.isKind(of: UITabBarController.self), state == true {
            return true
        }
        return false
    }
}

protocol NotModalViewController {}

protocol Alertable {
    func showAlert(title: String?, message: String?)
    func showAlert(title: String?, message: String?, handler: @escaping ((UIAlertAction) -> Void))
}

extension UIViewController {
    func showAlert(title: String? = nil, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(close)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String? = nil, message: String?, handler: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "OK", style: .cancel, handler: handler)
        alert.addAction(close)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String? = nil, textFieldPlaceholder: String? = nil, keyboardType: UIKeyboardType = .default, contentType: UITextContentType? = nil, message: String?, closeHandler:((UIAlertAction) -> Void)? = nil, submitHandler: @escaping ((String?) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "Cancel", style: .cancel, handler: closeHandler)
        var textField: UITextField!
        alert.addTextField { CLTextField in
            CLTextField.placeholder = textFieldPlaceholder
            textField = CLTextField
            textField.keyboardType = keyboardType
            if #available(iOS 10.0, *), let contentType = contentType {
                textField.textContentType = contentType
            }
        }
        let submit = UIAlertAction(title: "OK", style: .default) { (action) in
            submitHandler(textField.text)
        }
        alert.addAction(close)
        alert.addAction(submit)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String?, message: String?, closeHandler:((UIAlertAction) -> Void)?, submitHandler: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "Cancel", style: .cancel, handler: closeHandler)
        let submit = UIAlertAction(title: "OK", style: .default, handler: submitHandler)
        alert.addAction(close)
        alert.addAction(submit)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String?, attributedMessage: NSAttributedString, closeHandler:((UIAlertAction) -> Void)?, submitHandler: @escaping ((UIAlertAction) -> Void)){
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.setValue(attributedMessage, forKey: "attributedMessage")
        let close = UIAlertAction(title: "Cancel", style: .cancel, handler: closeHandler)
        let submit = UIAlertAction(title: "OK", style: .default, handler: submitHandler)
        alert.addAction(close)
        alert.addAction(submit)
        present(alert, animated: true, completion: nil)
    }
    
}
//
//extension UIViewController {
//    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissSearchBar))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//    
//    @objc func dismissSearchBar() {
//        (self.navigationItem.titleView as? UISearchBar)?.resignFirstResponder()
//        (self.navigationController as? SportNavigationController)?.resetRightBarButtons(for: self)
//    }
//}

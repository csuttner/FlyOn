//
//  ViewControllerExtensions.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/13/21.
//

import UIKit

extension UIViewController {
    
    func addObserver(action: Selector, name: NSNotification.Name) {
        NotificationCenter.default.addObserver(self, selector: action, name: name, object: nil)
    }
    
    func presentBasicAlert(title: String, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func presentReturningAlert(title: String, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (nil) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func getSpacedButtonItems(with customViews: [UIView]) -> [UIBarButtonItem] {
        var buttonItems = [UIBarButtonItem(systemItem: .flexibleSpace)]
        for view in customViews {
            buttonItems.append(UIBarButtonItem(customView: view))
            buttonItems.append(UIBarButtonItem(systemItem: .flexibleSpace))
        }
        return buttonItems
    }
    
}

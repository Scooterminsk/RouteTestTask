//
//  UIViewController + Extension.swift
//  RouteTestTask
//
//  Created by Zenya Kirilov on 20.10.22.
//

import UIKit

extension UIViewController {
    
    func alertError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionError = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(actionError)
        present(alert, animated: true)
    }
}

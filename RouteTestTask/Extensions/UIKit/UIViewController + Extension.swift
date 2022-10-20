//
//  UIViewController + Extension.swift
//  RouteTestTask
//
//  Created by Zenya Kirilov on 20.10.22.
//

import UIKit

extension UIViewController {
    
    func alertAddAddress(title: String, placeholder: String, complitionHandler: @escaping (String) -> Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default) { (action) in
            let tfText = alert.textFields?.first
            guard let text = tfText?.text else { return }
            complitionHandler(text)
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in

        }
        
        alert.addTextField { (tf) in
            tf.placeholder = placeholder
        }
        
        alert.addAction(actionOk)
        alert.addAction(actionCancel)
        
        present(alert, animated: true)
    }
    
    func alertError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionError = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(actionError)
        present(alert, animated: true)
    }
}

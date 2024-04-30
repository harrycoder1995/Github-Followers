//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 03/04/24.
//

import UIKit

extension UIViewController {
    func presentAlertOnMainThread(title: String,message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            
            self.present(alertVC, animated: true)
        }
    }
    
}

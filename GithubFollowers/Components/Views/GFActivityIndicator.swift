//
//  GFActivityIndicator.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 27/04/24.
//

import UIKit

class GFActivityIndicator {
    
    //MARK: - Properties
    
    static let shared = GFActivityIndicator()
    
    private var activityIndicator: UIActivityIndicatorView!
    private var containerView: UIView!
    
//MARK: - Initialisers
   private init() {
        configureView()
        configureActivityIndicatorView()
    }
    
    //MARK: - Configuration
    private func configureView() {
        containerView = UIView()
        containerView.frame = UIScreen.main.bounds
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0.8
    }
    
    private func configureActivityIndicatorView() {
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        
        containerView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    //MARK: - Actions
     func show() {
       let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.addSubview(containerView)
        activityIndicator.startAnimating()
    }
    
    func hide() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.activityIndicator.stopAnimating()
        }
    }
}

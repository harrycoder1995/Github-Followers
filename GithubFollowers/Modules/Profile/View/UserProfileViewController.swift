//
//  UserProfileViewController.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 30/04/24.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    var username: String!
    var userViewModel: UserProfileViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userViewModel = UserProfileViewModel()
        getUserDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func doneButtonTapped() {
        dismiss(animated: true)
    }

    
    //MARK: - Get User Details
    private func getUserDetails() {
        userViewModel.getUserDetails(for: username)
    }
}

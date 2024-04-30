//
//  SearchVC.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 28/03/24.
//

import UIKit

class SearchVC: UIViewController {

    //MARK: - Properties
    
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let followersButton = GFButton(backgroundColor: .systemGreen, titleText: "Get Followers")
    
    var isUsernameEntered: Bool {
        !usernameTextField.text!.isEmpty
    }
    
    //MARK: - View Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureLogoImageView()
        configureTextField()
        configureFollowersButton()
        addGestureToView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - SetUp UI methods
    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureFollowersButton() {
        view.addSubview(followersButton)
        
        followersButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            followersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            followersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            followersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            followersButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    private func addGestureToView() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - ACTION
    
    @objc func pushFollowerListVC() {
        guard isUsernameEntered else {
            presentAlertOnMainThread(title: "Empty Username", message: "Please enter a username to get the followers.", buttonTitle: "Ok")
            return
        }
        
        let followersVC = FollowersListVC()
        followersVC.username = usernameTextField.text
        followersVC.title = usernameTextField.text
        
        navigationController?.pushViewController(followersVC, animated: true)
    }

}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}

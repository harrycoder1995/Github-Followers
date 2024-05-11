//
//  UserProfileViewController.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 30/04/24.
//

import UIKit
import SafariServices


class UserProfileViewController: UIViewController {
    
    //MARK: - Properties
    var username: String!
    private var userViewModel: UserProfileViewModel!
    private var githubItemView: GFItemCardView!
    private var followersItemView: GFItemCardView!
    private var dateLabel: GFBodyLabel!
    private var headerView: UserInfoHeaderView!
    
    weak var delegate: FollowersListVCDelegate!

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userViewModel = UserProfileViewModel(delegate: self)
        getUserDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }
    
    //MARK: - UI Configuration
    private func configureView() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        
        navigationItem.rightBarButtonItem = barButtonItem
        
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        headerView = UserInfoHeaderView(frame: .zero)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func configureItemView() {
        githubItemView = GFItemCardView(frame: .zero)
        githubItemView.tag = 0
        githubItemView.delegate = self
        view.addSubview(githubItemView)
        
        followersItemView = GFItemCardView(frame: .zero)
        followersItemView.tag = 1
        followersItemView.delegate = self
        view.addSubview(followersItemView)
        
        NSLayoutConstraint.activate([
            githubItemView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            githubItemView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            githubItemView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
            githubItemView.heightAnchor.constraint(equalToConstant: 150),
            
            followersItemView.topAnchor.constraint(equalTo: githubItemView.bottomAnchor, constant: 20),
            followersItemView.leadingAnchor.constraint(equalTo: githubItemView.leadingAnchor, constant: 10),
            followersItemView.trailingAnchor.constraint(equalTo: githubItemView.trailingAnchor, constant: -10),
            followersItemView.heightAnchor.constraint(equalTo: githubItemView.heightAnchor)
        ])
        
        configureGithubItemView()
        configureFollowersItemView()
    }
    
    private func configureGithubItemView() {
        let user = userViewModel.getUser()
        githubItemView.leftView.setItem(for: .repos, and: user.publicRepos)
        githubItemView.rightView.setItem(for: .gists, and: user.publicGists)
        githubItemView.actionButton.configure(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    private func configureFollowersItemView() {
        let user = userViewModel.getUser()
        followersItemView.leftView.setItem(for: .followers, and: user.followers)
        followersItemView.rightView.setItem(for: .following, and: user.following)
        followersItemView.actionButton.configure(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    private func configureDateLabel() {
        dateLabel = GFBodyLabel(textAlignment: .center)
        dateLabel.text = "Github Since \(userViewModel.getDateOfGithubUser())"
        
        view.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: followersItemView.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: followersItemView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: followersItemView.trailingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
    @objc private func doneButtonTapped() {
        dismiss(animated: true)
    }

    
    //MARK: - Get User Details
    private func getUserDetails() {
        GFActivityIndicator.shared.show()
        userViewModel.getUserDetails(for: username)
    }
}

//MARK: - UserProfileViewModelDelegate
extension UserProfileViewController: UserProfileViewModelDelegate {
    
    func updateUIForUser(user: User) {
        GFActivityIndicator.shared.hide()
        DispatchQueue.main.async {
            self.headerView.populateData(for: user)
            self.configureItemView()
            self.configureDateLabel()
        }
    }
    
    func showError(message: String) {
        GFActivityIndicator.shared.hide()
        presentAlertOnMainThread(title: "Bad Stuff happened", message: message, buttonTitle: "Ok")
    }
    
    
}

//MARK: - UserProfileDelegate

extension UserProfileViewController: GFItemCardViewDelegate {
    func didTapOnActionButton(for tag: Int) {
        if tag == 0 {
            openGithubProfile()
        } else if tag == 1 {
            showFollowersForTheUser()
        }
    }
    
    func openGithubProfile() {
       let user = userViewModel.getUser()
        guard let url = URL(string: user.htmlUrl) else {
            presentAlertOnMainThread(title: "Invalid URL", message: "URL attached to this user is invalid.", buttonTitle: "Ok")
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    func showFollowersForTheUser() {
        dismiss(animated: true) {
            self.delegate.didFetchFollowers(for: self.username)
        }
        
    }
    
}

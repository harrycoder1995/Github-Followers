//
//  UserProfileViewModel.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 30/04/24.
//

import Foundation

protocol UserProfileViewModelDelegate: AnyObject {
    func updateUIForUser(user: User)
    func showError(message: String)
}

class UserProfileViewModel {
    
    private weak var delegate: UserProfileViewModelDelegate?
    private var user: User!
    
    init(delegate: UserProfileViewModelDelegate? = nil) {
        self.delegate = delegate
    }
    
    func getUser() -> User {
        user
    }
    
    func getDateOfGithubUser() -> String {
        user.createdAt.convertToDate().convertDateToString()
    }
    
    func getUserDetails(for username: String) {
        let requestConfig = UserRequestConfig(username: username)
        
        NetworkManager().fetchData(requestConfig: requestConfig) { (result: Result<User?,GFError>) in
            switch result {
            case .success(let user):
                self.user = user
                self.delegate?.updateUIForUser(user: self.user)
            case .failure(let failure):
                self.delegate?.showError(message: failure.rawValue)
            }
        }
    }
}

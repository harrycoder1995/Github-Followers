//
//  UserProfileViewModel.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 30/04/24.
//

import Foundation

class UserProfileViewModel {
    func getUserDetails(for username: String) {
        let requestConfig = UserRequestConfig(username: username)
        
        NetworkManager().fetchData(requestConfig: requestConfig) { (result: Result<User?,GFError>) in
            switch result {
            case .success(let user):
                print(user)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

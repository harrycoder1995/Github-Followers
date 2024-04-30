//
//  FollowersListViewModel.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 11/04/24.
//

import Foundation

protocol FollowersListDelegate: AnyObject {
    func reloadData()
    func showError(message: String)
}

class FollowersListViewModel {
    
    //MARK: - Properties
    private weak var delegate: FollowersListDelegate?
    private var manager: NetworkManager
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    private var followersList: [Follower]? = []
    private var filteredFollowers:[Follower] = []
    
    
    //MARK: - Initialiser
    init(delegate: FollowersListDelegate? = nil, manager: NetworkManager) {
        self.delegate = delegate
        self.manager = manager
    }
    
    //MARK: - Helper Methods
    
    func getFollower(for index: Int) -> Follower? {
        let activeArray = isSearching ? filteredFollowers : followersList!
        return activeArray[index]
    }
    
    func getFollowers() -> [Follower] {
        followersList ?? []
    }
       
    //MARK: - API Calls
    func fetchListOfFollowers(for username: String)  {
        let followersService = FollowersRequestConfig(username: username, page: page)
        
        manager.fetchData(requestConfig: followersService) { [weak self] (result: Result<[Follower]?, GFError>) in
            
            guard let weakSelf = self else { return }
            
            switch result {
            case .success(let followers):
                
                if let followers = followers {
                    if followers.count < 100 { weakSelf.hasMoreFollowers = false }
                    weakSelf.followersList?.append(contentsOf: followers)
                }
                
                weakSelf.delegate?.reloadData()
            case .failure(let failure):
                weakSelf.delegate?.showError(message: failure.rawValue)
            }
        }
    }
    
    func fetchMoreFollowers(for username: String) {
        guard hasMoreFollowers else { return }
        page += 1
        fetchListOfFollowers(for: username)
    }
    
    func filterFollowers(by filterText: String) -> [Follower] {
        filteredFollowers = followersList!.filter { $0.login.lowercased().contains(filterText.lowercased()) }
        
        return filteredFollowers
    }
}

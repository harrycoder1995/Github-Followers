//
//  FavoriteViewModel.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 11/05/24.
//

import Foundation

protocol FavoriteViewModelDelegate: AnyObject {
    func didFetchFollowers()
    func didFailToFetchFollowers(message: String)
    func didUpdateUIForFollowers(message: String)
}

class FavoriteViewModel {
    
    weak var delegate: FavoriteViewModelDelegate!
    private(set) var favoriteFollowers: [Follower]!
    
    init(delegate: FavoriteViewModelDelegate) {
        self.delegate = delegate
    }
        
    func getFavorites() {
        PersistenceManager.shared.getFollowers {[weak self] result in
            
            guard let weakSelf = self else { return }
            
            switch result {
            case .success(let success):
                weakSelf.favoriteFollowers = success
                weakSelf.delegate.didFetchFollowers()
            case .failure(let failure):
                weakSelf.delegate.didFailToFetchFollowers(message:failure.rawValue)
            }
        }
    }
    
    func removeFollowerFromFavorite(for index: Int) {
        let follower = favoriteFollowers[index]
        
        PersistenceManager.shared.remove(follower: follower ) { [weak self] error in
            
            guard let weakSelf = self else { return }
            
            guard let _ = error else {
                weakSelf.favoriteFollowers.removeAll { $0.login == follower.login }
                weakSelf.delegate.didUpdateUIForFollowers(message: "Successfully removed from favorites list")
                return
            }
            
            weakSelf.delegate.didFailToFetchFollowers(message:"Unable to remove follower from favorites list")
        }
    }
}

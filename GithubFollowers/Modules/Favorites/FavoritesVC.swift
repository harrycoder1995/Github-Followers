//
//  FavoritesVC.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 28/03/24.
//

import UIKit

class FavoritesVC: UIViewController {
    
    private var favoriteTableView: UITableView!
    private var favoriteFollowers: [Follower] = []
    private var emptyView: GFEmptyView!
    
    private var favoriteViewModel: FavoriteViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteViewModel = FavoriteViewModel(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        favoriteViewModel.getFavorites()
    }
    
    func configureUI() {
        if favoriteViewModel.favoriteFollowers.isEmpty {
            addEmptyView()
        }else {
            configureTableView()
        }
    }
    
    func addEmptyView() {
        emptyView = GFEmptyView(message: "There is no favorite followers. Please do add to favorite.")
        emptyView.frame = view.bounds
        view.addSubview(emptyView)
    }
    
    func reloadTableView(){
        if favoriteViewModel.favoriteFollowers.isEmpty {
            addEmptyView()
        }else {
            favoriteTableView.reloadData()
        }
    }
    
    func configureTableView() {
        favoriteTableView = UITableView(frame: view.bounds, style: .grouped)
        favoriteTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(favoriteTableView)
       
        favoriteTableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        
    }

}

extension FavoritesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteViewModel.favoriteFollowers.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier, for: indexPath) as! FavoritesTableViewCell
        
        cell.setFavorite(favorite: favoriteViewModel.favoriteFollowers[indexPath.row])
        return cell
    }
    
    
}

extension FavoritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _,_,completion in
            
            self.favoriteViewModel.removeFollowerFromFavorite(for: indexPath.row)
            completion(true)
            
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let follower = favoriteViewModel.favoriteFollowers[indexPath.row]
        let followerVC = FollowersListVC()
        followerVC.username = follower.login
        
        navigationController?.pushViewController(followerVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension FavoritesVC: FavoriteViewModelDelegate {
    func didFetchFollowers() {
        configureUI()
    }
    
    func didFailToFetchFollowers(message: String) {
        presentAlertOnMainThread(title: "Favorites", message: message, buttonTitle: "Ok")
    }
    
    func didUpdateUIForFollowers(message: String) {
        presentAlertOnMainThread(title: "Favorites", message: message, buttonTitle: "Ok")
        reloadTableView()
    }
    
    
}

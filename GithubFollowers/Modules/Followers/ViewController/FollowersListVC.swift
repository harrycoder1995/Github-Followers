//
//  FollowersListVC.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 03/04/24.
//

import UIKit

protocol FollowersListVCDelegate: AnyObject {
    func didFetchFollowers(for username: String)
}

class FollowersListVC: UIViewController {
    
    //MARK: - Sections
    enum Sections { case main }
    
//MARK: - Properties
    var username: String!
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Sections, Follower>!
    private var searchBar: UISearchBar!
    var followersViewModel: FollowersListViewModel!

//MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()
        configureCollectionView()
        configureDiffableDataSource()
        
        followersViewModel = FollowersListViewModel(delegate: self, manager: NetworkManager())
        fetchFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(addToFavorite))
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc func addToFavorite() {
        GFActivityIndicator.shared.show()
        followersViewModel.getUserInfo(for: username)
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero ,collectionViewLayout: UIHelper.createCollectionFlowLayout(in: view))
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.identifier)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func configureSearchBar() {
        searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = self
        searchBar.placeholder = "Search for a username"
        searchBar.backgroundImage = UIImage()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    //MARK: - UICollectionViewDiffableDataSource
    
    func configureDiffableDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.identifier, for: indexPath) as! FollowerCell
            
            cell.set(follower: follower)
            
            return cell
        })
    }
    
    func updateCollectionView(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
//MARK: - FetchFollowers
   private func fetchFollowers() {
       GFActivityIndicator.shared.show()
        followersViewModel.fetchListOfFollowers(for: username)
    }

}

//MARK: - FollowersListDelegate
extension FollowersListVC: FollowersListDelegate {
    func reloadData() {
        GFActivityIndicator.shared.hide()
        
        if followersViewModel.getFollowers().isEmpty {
            DispatchQueue.main.async {
                let emptyView = GFEmptyView(message: "This user doesn't have any followers.")
                emptyView.frame = self.view.bounds
                self.view.addSubview(emptyView)
            }
            
            return
        }
        
        updateCollectionView(on: followersViewModel.getFollowers())
    }
    
    func didAddToFavorites(message: String) {
        GFActivityIndicator.shared.hide()
        presentAlertOnMainThread(title: "Add To Favorites", message: message, buttonTitle: "Ok")
    }
    
    func showError(message: String) {
        GFActivityIndicator.shared.hide()
        presentAlertOnMainThread(title: "Bad Stuff Happened", message: message, buttonTitle: "Ok")
    }
}

//MARK: - UICollectionViewDelegate
extension FollowersListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        if offSetY > contentHeight - height {
            followersViewModel.page += 1
            if followersViewModel.hasMoreFollowers {
                fetchFollowers()
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower = followersViewModel.getFollower(for: indexPath.row)
        
        let userVC = UserProfileViewController()
        userVC.delegate = self
        userVC.username = follower?.login
        
        let navigationController = UINavigationController(rootViewController: userVC)
        present(navigationController, animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension FollowersListVC: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        searchBar.setShowsCancelButton(true, animated: true)
        
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        
        followersViewModel.isSearching = true
        let filteredData = followersViewModel.filterFollowers(by: searchText)
        updateCollectionView(on: filteredData)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
        followersViewModel.isSearching = false
        updateCollectionView(on: followersViewModel.getFollowers())
    }
}

//MARK: -

extension FollowersListVC: FollowersListVCDelegate {
    func didFetchFollowers(for username: String) {
        self.username = username
        title = username
        followersViewModel.resetDataSource()
        collectionView.setContentOffset(.zero, animated: true)
        fetchFollowers()
    }
}

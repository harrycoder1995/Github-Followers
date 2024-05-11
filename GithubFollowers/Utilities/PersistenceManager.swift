//
//  PersistenceManager.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 10/05/24.
//

import Foundation

struct PersistenceManager {
    
    enum Key: String {
        case favorites = "favorites"
    }
    
    static let shared = PersistenceManager()
    private let defaults = UserDefaults.standard
    private init() {}
    
    func getFollowers(completion: @escaping(Result<[Follower], GFError>) -> Void) {
        guard let followersData = defaults.object(forKey: Key.favorites.rawValue) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let followers = try decoder.decode([Follower].self, from: followersData)
            completion(.success(followers))
        }catch {
            completion(.failure(.unableToRetrieveFavorites))
        }
    }
    
   private func save(followers: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(followers)
            defaults.set(encodedData, forKey: Key.favorites.rawValue)
            return nil
        } catch {
            return .unableToRetrieveFavorites
        }
    }
    
    func remove(follower: Follower, completion: @escaping(GFError?)->Void) {
        getFollowers { result in
            switch result {
            case .success(var favoriteFollowers):
                favoriteFollowers.removeAll{ $0.login == follower.login }
                
                completion(save(followers: favoriteFollowers))
            case .failure(let failure):
                completion(failure)
            }
        }
    }
    
    func update(follower: Follower, completion: @escaping(GFError?)-> Void) {
        getFollowers { result in
            switch result {
            case .success(var favoriteFollower):
                guard favoriteFollower.contains (where: { $0.login == follower.login }) else {
                    favoriteFollower.append(follower)
                    completion(self.save(followers: favoriteFollower))
                    return
                }
                
                completion(.userIsAlreadyAddedToFavorites)
            case .failure(let failure):
                completion(failure)
            }
        }
    }
}

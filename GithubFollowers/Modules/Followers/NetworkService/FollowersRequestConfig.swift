//
//  FollowersRequestConfig.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 04/04/24.
//

import Foundation

struct FollowersRequestConfig: RequestConfig {
    
    let username: String
    let page: Int
    
    var path: String {
        "/users/\(username)/followers"
    }
    
    var headers: [String : String]? {
        ["accept":"application/vnd.github+json"]
    }
    
    var parameters: [String : String]? {
        [
            "per_page":"100",
            "page":"\(page)"
        ]
    }
    
}

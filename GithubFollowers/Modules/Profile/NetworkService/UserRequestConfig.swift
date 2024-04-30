//
//  UserRequestConfig.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 30/04/24.
//

import Foundation

struct UserRequestConfig: RequestConfig {
    
    let username: String
    
    var path: String {
        "/users/\(username)"
    }
    
    var headers: [String : String]? {
        ["accept":"application/vnd.github+json"]
    }
}

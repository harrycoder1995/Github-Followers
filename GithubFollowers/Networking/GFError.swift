//
//  NetworkError.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 04/04/24.
//

import Foundation

enum GFError: String, Error {
    case invalidURL = "Invalid Url, Please try again with correct url."
    case unableToFetch = "Unable to fetch data, Please try again after sometime."
    case invalidResponse = "Invalid response recieved from the server."
    case unableToParseData = "Unable to parse the data recieved from the server."
    
    case noFollowersFound = "User doesn't follow to any one!!."
}

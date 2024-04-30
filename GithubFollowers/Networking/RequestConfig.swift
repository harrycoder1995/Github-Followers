//
//  RequestConfig.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 04/04/24.
//

import Foundation

protocol RequestConfig {
    var path: String { get }
    var method: HTTPMethods { get }
    var headers: [String: String]? { get }
    var parameters: [String: String]? { get }
    var body: [String:Any]? { get }
}

extension RequestConfig {
    var method: HTTPMethods {
        .get
    }
    
    var parameters: [String: String]? {
        nil
    }
    
    var body: [String: Any]? {
        nil
    }
}

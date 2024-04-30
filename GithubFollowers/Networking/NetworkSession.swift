//
//  NetworkSession.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 04/04/24.
//

import Foundation

protocol NetworkSession {
    func loadData(with urlRequest: URLRequest, completionHanlder: @escaping (Data?,URLResponse?, Error?)->Void)
    func loadData(with url: URL, completionHanlder: @escaping (Data?,URLResponse?, Error?)->Void)
}


//
//  URLSession+Ext.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 04/04/24.
//

import Foundation

extension URLSession: NetworkSession {
    func loadData(with urlRequest: URLRequest, completionHanlder: @escaping (Data?,URLResponse?,(any Error)?) -> Void) {
        let task = dataTask(with: urlRequest, completionHandler: completionHanlder)
        
        task.resume()
    }
    
    func loadData(with url: URL, completionHanlder: @escaping (Data?,URLResponse?,(any Error)?) -> Void) {
        let task = dataTask(with: url, completionHandler: completionHanlder)
        
        task.resume()
    }
    
}

//
//  RequestBuilder.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 04/04/24.
//

import Foundation

final class RequestBuilder {
    static func makeRequest(with config: RequestConfig, and baseUrl: String = "http://api.github.com") -> URLRequest? {
        
        var urlComponets = URLComponents(string: baseUrl+config.path)
        
        if let parameters = config.parameters {
            urlComponets?.queryItems = parameters.map { param in
                URLQueryItem(name: param.key, value: param.value)
            }
        }
       
        
        guard let url = urlComponets?.url else {
            return nil
        }
        
        
        var request = URLRequest(url: url)
        
        request.httpMethod = config.method.rawValue
        request.allHTTPHeaderFields = config.headers
        request.httpBody = createHttpBody(config)
        request.timeoutInterval = 10
        
        return request
    }
    
    private static func createHttpBody(_ config: RequestConfig) -> Data? {
        guard let body = config.body else {
                   return nil
               }
        return try? JSONSerialization.data(withJSONObject: body)
    }
}

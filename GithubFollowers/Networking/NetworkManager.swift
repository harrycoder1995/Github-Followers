//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 04/04/24.
//

import UIKit

class NetworkManager {
    
    private let session: NetworkSession
    
    let cache = NSCache<NSString, UIImage>()
    
    private static let baseURL = "https://api.github.com"
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchData<T:Decodable>(requestConfig: RequestConfig,baseURL: String = baseURL, completionHanlder: @escaping (Result<T?, GFError>) -> Void) {
        guard let urlRequest = RequestBuilder.makeRequest(with: requestConfig, and: baseURL) else {
            completionHanlder(.failure(.invalidURL))
            return
        }
        
        session.loadData(with: urlRequest) { data, response, error in
            if error != nil {
                completionHanlder(.failure(.unableToFetch))
            }

            do {
                let decodedData: T = try ResponseDecoder.decodeResponse(data, response)
                completionHanlder(.success(decodedData))
            } catch {
                completionHanlder(.failure(.unableToParseData))
            }
            
        }
    }
    
    func downloadImageData(for urlString: String, completion: @escaping (Data?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        session.loadData(with: url) { data, response , error in
            guard error == nil else {
                completion(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil)
                return
            }
            
            completion(data)
        }
    }
}

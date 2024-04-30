//
//  CacheManager.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 27/04/24.
//

import UIKit


protocol CacheProtocol {
    
    associatedtype Input = AnyObject
    associatedtype Output = Decodable
    
    var cache: NSCache<AnyObject,AnyObject> { get set }
    
    func cache(object: Input, forKey key: String) throws
    func getCached(forKey key: String) throws -> Output
}

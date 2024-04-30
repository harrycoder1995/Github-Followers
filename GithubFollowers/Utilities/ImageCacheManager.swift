//
//  ImageCacheManager.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 27/04/24.
//

import UIKit

class ImageCacheManager: CacheProtocol {
    
    static let shared = ImageCacheManager()
    
    
    internal var cache: NSCache<AnyObject, AnyObject> = NSCache<AnyObject, AnyObject>()

    private init() {}
    
    func cache(object: UIImage, forKey key: String)  {
        let cachedKey = NSString(string: key)
        cache.setObject(object, forKey: cachedKey)
    }
    
    func getCached(forKey key: String)  -> UIImage? {
        let cachedKey = NSString(string: key)
        return cache.object(forKey: cachedKey) as? UIImage
    }
    
}

//
//  GFImageView.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 26/04/24.
//

import UIKit

class GFImageView: UIImageView {
    
    //MARK: - Properties
    let placeholderImage = UIImage(named: "avatar-placeholder")!

    //MARK: - View Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Configuration
    private func configure() {
        layer.cornerRadius = 10
        image = placeholderImage
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(for urlString: String) {
        
        if let image = ImageCacheManager.shared.getCached(forKey: urlString)  {
            self.image = image
            return
        }
        
        
        NetworkManager().downloadImageData(for: urlString) { [weak self] imageData in
            
            guard let weakSelf = self else { return }
            guard let imageData = imageData , let image = UIImage(data: imageData) else { return }
            
            ImageCacheManager.shared.cache(object: image, forKey: urlString)
            
            DispatchQueue.main.async {
                weakSelf.image = image
            }
        }
    }
}


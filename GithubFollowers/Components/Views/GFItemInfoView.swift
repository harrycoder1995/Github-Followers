//
//  GFItemInfoView.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 01/05/24.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {
    
    private var itemImageView = UIImageView()
    private var primaryLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    private var secondaryLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(itemImageView)
        addSubview(primaryLabel)
        addSubview(secondaryLabel)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: topAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 20),
            itemImageView.heightAnchor.constraint(equalToConstant: 20),
            
            
            primaryLabel.centerYAnchor.constraint(equalTo: itemImageView.centerYAnchor),
            primaryLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 12),
            primaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            secondaryLabel.topAnchor.constraint(equalTo: primaryLabel.bottomAnchor, constant: 12),
            secondaryLabel.leadingAnchor.constraint(equalTo: primaryLabel.leadingAnchor),
            secondaryLabel.trailingAnchor.constraint(equalTo: primaryLabel.trailingAnchor),
            secondaryLabel.heightAnchor.constraint(equalToConstant: 18)
        
        ])
    }
    
    func setItem(for type: ItemInfoType, and count: Int) {
        switch type {
        case .repos:
            itemImageView.image = UIImage(systemName: "folder")
            primaryLabel.text = "Public Repos"
        case .gists:
            itemImageView.image = UIImage(systemName: "text.alignleft")
            primaryLabel.text = "Public Gists"
        case .followers:
            itemImageView.image = UIImage(systemName: "heart")
            primaryLabel.text = "Followers"
        case .following:
            itemImageView.image = UIImage(systemName: "person.2")
            primaryLabel.text = "Following"
        }
        
        secondaryLabel.text = "\(count)"
    }
}

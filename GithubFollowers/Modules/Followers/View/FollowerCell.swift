//
//  FollowerCell.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 26/04/24.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = "FollowerCell"
    private var avatarImageView = GFImageView(frame: .zero)
    private var followerTitleLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    private let padding: CGFloat = 8
    
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
        contentView.addSubview(avatarImageView)
        contentView.addSubview(followerTitleLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            
            followerTitleLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: padding),
            followerTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            followerTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            followerTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func set(follower: Follower) {
        followerTitleLabel.text = follower.login
        avatarImageView.downloadImage(for: follower.avatarUrl)
    }
    
    
}

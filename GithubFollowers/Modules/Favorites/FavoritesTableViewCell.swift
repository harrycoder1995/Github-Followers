//
//  FavoritesTableViewCell.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 10/05/24.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    static let identifier = "FavoritesTableViewCell"
    private var avatarImage: GFImageView!
    private var titleLabel: GFTitleLabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFavorite(favorite: Follower) {
        avatarImage.downloadImage(for: favorite.avatarUrl)
        titleLabel.text = favorite.login
    }
    
    private func configure() {
        
        accessoryType = .disclosureIndicator
        
        avatarImage = GFImageView(frame: .zero)
        contentView.addSubview(avatarImage)
        
        titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 28)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            avatarImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            avatarImage.heightAnchor.constraint(equalToConstant: 60),
            avatarImage.widthAnchor.constraint(equalTo: avatarImage.heightAnchor),
            
            
            titleLabel.centerYAnchor.constraint(equalTo: avatarImage.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }

}

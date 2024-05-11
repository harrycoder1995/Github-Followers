//
//  UserInfoHeaderView.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 01/05/24.
//

import UIKit

class UserInfoHeaderView: UIView {
    
    //MARK: - Properties
    
    private var avatarImageView = GFImageView(frame: .zero)
    
    private var usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 36)
    private var nameLabel = GFSecondaryLabel(fontSize: 18)
    private var locationIcon = UIImageView(image: UIImage(systemName: "mappin.and.ellipse"))
    private var locationLabel = GFSecondaryLabel(fontSize: 18)
    private var bioLabel = GFBodyLabel(textAlignment: .left)
    
    private var labelContainerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
        configureLabelContainerView()
        
        addSubview(avatarImageView)
        addSubview(labelContainerView)
        addSubview(bioLabel)
                
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            labelContainerView.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            labelContainerView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            labelContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: labelContainerView.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        
        ])
    }
    
    private func configureLabelContainerView() {
        labelContainerView = UIView(frame: .zero)
        labelContainerView.addSubview(usernameLabel)
        labelContainerView.addSubview(nameLabel)
        labelContainerView.addSubview(locationIcon)
        labelContainerView.addSubview(locationLabel)
        
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: labelContainerView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: labelContainerView.leadingAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: labelContainerView.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 6),
            nameLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
        
            locationIcon.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            locationIcon.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            locationIcon.widthAnchor.constraint(equalToConstant: 20),
            locationIcon.heightAnchor.constraint(equalToConstant: 20),
            locationIcon.bottomAnchor.constraint(equalTo: labelContainerView.bottomAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: locationIcon.topAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor,constant: 12),
            locationLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            locationLabel.bottomAnchor.constraint(equalTo: locationIcon.bottomAnchor)
        ])
    }
    
    func populateData(for user: User) {
        avatarImageView.downloadImage(for: user.avatarUrl)
        usernameLabel.text = user.login
        nameLabel.text = user.name
        locationLabel.text = user.location
        
        bioLabel.text = user.bio
        bioLabel.numberOfLines = 3
        
        locationIcon.tintColor = .secondaryLabel
    }
}

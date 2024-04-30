//
//  GFEmptyView.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 30/04/24.
//

import UIKit

class GFEmptyView: UIView {
    
    private var primaryLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    private var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        primaryLabel.text = message
        configure()
    }
    
    private func configure() {
        addSubview(primaryLabel)
        addSubview(imageView)
        
        backgroundColor = .systemBackground
        
        primaryLabel.textColor = .secondaryLabel
        primaryLabel.numberOfLines = 3
        
        
        imageView.image = UIImage(named: "empty-state-logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            primaryLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            primaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            primaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            primaryLabel.heightAnchor.constraint(equalToConstant: 200),
            
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 200),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40)
           
           
        ])
    }
}

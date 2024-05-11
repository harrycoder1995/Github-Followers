//
//  GFButton.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 28/03/24.
//

import UIKit

class GFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, titleText: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(titleText, for: .normal)
        
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel?.textColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }

}

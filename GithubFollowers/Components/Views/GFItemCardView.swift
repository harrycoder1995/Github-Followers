//
//  GFItemCardView.swift
//  GithubFollowers
//
//  Created by Harendra Rana on 01/05/24.
//

import UIKit

protocol GFItemCardViewDelegate: AnyObject {
    func didTapOnActionButton(for tag: Int)
}

class GFItemCardView: UIView {

    var leftView = GFItemInfoView()
    var rightView = GFItemInfoView()
    
    private var stackView: UIStackView!
    var actionButton = GFButton()
    weak var delegate: GFItemCardViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 20
        
        translatesAutoresizingMaskIntoConstraints = false
        stackView = UIStackView(arrangedSubviews: [leftView, rightView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
        
        configureActionButton()
    }
    
    
    private func configureActionButton() {
        addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            actionButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
    
    @objc private func actionButtonTapped() {
        delegate?.didTapOnActionButton(for: tag)
    }
}

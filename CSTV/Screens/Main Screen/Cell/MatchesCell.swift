//
//  SceneDelegate.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import UIKit

class MatchesCell: UITableViewCell {
     
    static let matchesCellReuseID = "MatchesCell"
    private let matchesView = MatchesView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        addSubview(matchesView)
        backgroundColor = .clear
        NSLayoutConstraint.activate([
            matchesView.topAnchor.constraint(equalTo: topAnchor),
            matchesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            matchesView.trailingAnchor.constraint(equalTo: trailingAnchor),
            matchesView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -23),
        ])
    }
    
}

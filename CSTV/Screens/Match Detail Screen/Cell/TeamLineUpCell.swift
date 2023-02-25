//
//  SceneDelegate.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import UIKit

class TeamLineUpCell: UITableViewCell {

    static let teamLineUpReuseID = "TeamLineUpCell"
    private let firstTeamLineUp = FirstTeamLineUpView()
    private let secondTeamLineUp = SecondTeamLineUpView()
    
    private lazy var teamsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 13
        
        stack.addArrangedSubview(firstTeamLineUp)
        stack.addArrangedSubview(secondTeamLineUp)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        addSubview(teamsStackView)
        backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            teamsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            teamsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            teamsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            teamsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
}

//
//  SceneDelegate.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import UIKit

class OpposingTeamsView: UIView {
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.addArrangedSubview(firsTeamStackView)
        stack.addArrangedSubview(versusLabel)
        stack.addArrangedSubview(secondTeamStackView)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var firsTeamStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 10
        stack.addArrangedSubview(firstTeamLogo)
        stack.addArrangedSubview(firstTeamTitle)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let firstTeamLogo: UIImageView = {
        let logo = UIImageView()
        logo.heightAnchor.constraint(equalToConstant: 60).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 60).isActive = true
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.image = CSTVImages.teamImgPlaceholder
        return logo
    }()
    
    let firstTeamTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Time 1"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var secondTeamStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 10
        stack.addArrangedSubview(secondTeamLogo)
        stack.addArrangedSubview(secondTeamTitle)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let secondTeamLogo: UIImageView = {
        let logo = UIImageView()
        logo.heightAnchor.constraint(equalToConstant: 60).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 60).isActive = true
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.image = CSTVImages.teamImgPlaceholder
        return logo
    }()
    
    let secondTeamTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Time 2"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    let versusLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "VS"
        label.textAlignment = .center
        label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(mainStackView)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }

}
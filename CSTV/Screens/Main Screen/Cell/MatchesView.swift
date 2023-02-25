//
//  SceneDelegate.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import UIKit

class MatchesView: UIView {
    
    private let matchTimeView = MatchScheduleView()
    private let opposingTeams = OpposingTeamsView()
    
    private let separatorView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = CSTVColors.futureMatchColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    private let leagueLogo: UIImageView = {
        let logo = UIImageView()
        logo.backgroundColor = .systemRed
        logo.layer.cornerRadius = 8
        logo.clipsToBounds = true
        logo.image = CSTVImages.teamImgPlaceholder
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private let leagueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "League + serie"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 8)
        label.translatesAutoresizingMaskIntoConstraints = false
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
        backgroundColor = CSTVColors.cellColor
        layer.cornerRadius = 16
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        addSubviews(matchTimeView, opposingTeams, separatorView, leagueLogo, leagueLabel)
        NSLayoutConstraint.activate([
            matchTimeView.topAnchor.constraint(equalTo: topAnchor),
            matchTimeView.trailingAnchor.constraint(equalTo: trailingAnchor),
            matchTimeView.heightAnchor.constraint(equalToConstant: 25),
            matchTimeView.widthAnchor.constraint(equalToConstant: 100),
            leagueLogo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            leagueLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            leagueLogo.heightAnchor.constraint(equalToConstant: 16),
            leagueLogo.widthAnchor.constraint(equalToConstant: 16),
            leagueLabel.centerYAnchor.constraint(equalTo: leagueLogo.centerYAnchor),
            leagueLabel.leadingAnchor.constraint(equalTo: leagueLogo.trailingAnchor, constant: 8),
            leagueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: leagueLogo.topAnchor, constant: -8),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            opposingTeams.topAnchor.constraint(equalTo: matchTimeView.bottomAnchor, constant: 18),
            opposingTeams.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            opposingTeams.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            opposingTeams.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -18),
        ])
    }

}

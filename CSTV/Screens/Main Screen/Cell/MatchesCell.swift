//
//  SceneDelegate.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import UIKit

final class MatchesCell: UITableViewCell {
    
    //MARK: - properties

    static let matchesCellReuseID   = "MatchesCell"

    //MARK: - Components

    private let matchTimeView       = MatchScheduleView()
    private let opposingTeams       = OpposingTeamsView()
    
    private lazy var matchTimeLabel: UILabel = {
        let label           = UILabel(frame: .zero)
        label.textColor     = .white
        label.textAlignment = .center
        label.font          = UIFont.systemFont(ofSize: 8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separatorView: UIView = {
        let view                = UIView(frame: .zero)
        view.backgroundColor    = CSTVColors.futureMatchColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    private let leagueLogo: UIImageView = {
        let logo                = UIImageView()
        logo.layer.cornerRadius = 8
        logo.clipsToBounds      = true
        logo.image              = CSTVImages.teamImgPlaceholder
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private lazy var leagueLabel: UILabel = {
        let label       = UILabel(frame: .zero)
        label.text      = "Unknown"
        label.textColor = .white
        label.font      = CSTVFont.robotoRegular(size: 8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainView: UIView = {
        let view                = UIView(frame: .zero)
        view.backgroundColor    = CSTVColors.cellColor
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubviews(matchTimeView, leagueLogo, leagueLabel, separatorView, opposingTeams)
        matchTimeView.addSubview(matchTimeLabel)
        
        NSLayoutConstraint.activate([
            matchTimeView.topAnchor.constraint(equalTo: view.topAnchor),
            matchTimeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            matchTimeView.heightAnchor.constraint(equalToConstant: 25),
            matchTimeView.widthAnchor.constraint(equalToConstant: 70),
            
            leagueLogo.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            leagueLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            leagueLogo.heightAnchor.constraint(equalToConstant: 16),
            leagueLogo.widthAnchor.constraint(equalToConstant: 16),
            
            leagueLabel.centerYAnchor.constraint(equalTo: leagueLogo.centerYAnchor),
            leagueLabel.leadingAnchor.constraint(equalTo: leagueLogo.trailingAnchor, constant: 8),
            leagueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            matchTimeLabel.centerXAnchor.constraint(equalTo: matchTimeView.centerXAnchor),
            matchTimeLabel.centerYAnchor.constraint(equalTo: matchTimeView.centerYAnchor),
            
            separatorView.bottomAnchor.constraint(equalTo: leagueLogo.topAnchor, constant: -8),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            opposingTeams.topAnchor.constraint(equalTo: matchTimeView.bottomAnchor, constant: 18),
            opposingTeams.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            opposingTeams.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            opposingTeams.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -18),
        ])
        view.clipsToBounds = true
        return view
    }()
    
    //MARK: - Life cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup method
    
    func set(matches: Matches) {
        leagueLabel.text = matches.league.name + " " + (matches.serie.name ?? "")
        
        if matches.status == "running" {
            matchTimeView.backgroundColor = CSTVColors.liveMatchColor
            matchTimeLabel.text = "AGORA"
        } else {
            matchTimeView.backgroundColor = CSTVColors.futureMatchColor
            matchTimeLabel.text = matches.beginAt?.convertStringToDayHourFormat()
        }
        
        if let imgUrl = matches.league.imageUrl {
            leagueLogo.downloadImageForCash(fromUrl: imgUrl)
        }
        
        opposingTeams.configureFields(with: matches)
       
        
    }
    
    //MARK: - Configuration method

    private func configureCell() {
        addSubview(mainView)
        mainView.addSubview(matchTimeView)

        backgroundColor = .clear
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -23)
        ])
    }
    
}

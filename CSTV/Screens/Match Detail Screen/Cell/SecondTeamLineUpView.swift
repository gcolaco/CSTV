//
//  SceneDelegate.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import UIKit

class SecondTeamLineUpView: UIView {
    
    private let secondTeamPlayerImg: UIImageView = {
        let logo = UIImageView()
        logo.layer.cornerRadius = 8
        logo.contentMode = .scaleAspectFit
        logo.tintColor = CSTVColors.futureMatchColor
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.image = CSTVImages.playerImgPlaceholder
        return logo
    }()
    
    private let secondTeamPlayerNickname: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Nickname"
        label.textColor = CSTVColors.lightCSTVBlue
        label.adjustsFontSizeToFitWidth   = true
        label.minimumScaleFactor          = 0.9
        label.lineBreakMode               = .byTruncatingTail
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondTeamPlayerName: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Nome Jogador"
        label.textColor = CSTVColors.lightCSTVBlue
        label.adjustsFontSizeToFitWidth   = true
        label.minimumScaleFactor          = 0.9
        label.lineBreakMode               = .byTruncatingTail
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.bottomLeft, .topLeft], radius: 12.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubviews(secondTeamPlayerImg, secondTeamPlayerNickname, secondTeamPlayerName)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = CSTVColors.cellColor

        NSLayoutConstraint.activate([
            secondTeamPlayerImg.topAnchor.constraint(equalTo: topAnchor, constant: -3),
            secondTeamPlayerImg.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            secondTeamPlayerImg.heightAnchor.constraint(equalToConstant: 50),
            secondTeamPlayerImg.widthAnchor.constraint(equalToConstant: 50),
            secondTeamPlayerNickname.centerYAnchor.constraint(equalTo: secondTeamPlayerImg.centerYAnchor),
            secondTeamPlayerNickname.leadingAnchor.constraint(equalTo: secondTeamPlayerImg.trailingAnchor, constant: 16),
            secondTeamPlayerNickname.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            secondTeamPlayerName.topAnchor.constraint(equalTo: secondTeamPlayerNickname.bottomAnchor, constant: 6),
            secondTeamPlayerName.leadingAnchor.constraint(equalTo: secondTeamPlayerNickname.leadingAnchor),
            secondTeamPlayerName.trailingAnchor.constraint(equalTo: secondTeamPlayerNickname.trailingAnchor)
        ])
    }
    
    
    func setupView(with player: Player) {
        if let playerImgUrl = player.imageUrl {
            secondTeamPlayerImg.downloadImageForCash(fromUrl: playerImgUrl)
        }
        
        if let playerFirstName = player.firstName, let playerLastName = player.lastName {
            secondTeamPlayerName.text = playerFirstName + " " + playerLastName
        } else {
            secondTeamPlayerName.text = "Unknown"
        }
        
        secondTeamPlayerNickname.text = player.nickname ?? "Unknown"
        
    }
    
}

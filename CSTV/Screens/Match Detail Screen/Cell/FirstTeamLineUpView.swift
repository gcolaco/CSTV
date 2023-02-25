//
//  SceneDelegate.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import UIKit

class FirstTeamLineUpView: UIView {

    private let firstTeamPlayerImg: UIImageView = {
        let logo = UIImageView()
        logo.layer.cornerRadius = 8
        logo.contentMode = .scaleAspectFill
        logo.clipsToBounds = true
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.image = CSTVImages.playerImgPlaceholder
        return logo
    }()
    
    let firstTeamPlayerNickname: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Nickname"
        label.textColor = CSTVColors.lightCSTVBlue
        label.adjustsFontSizeToFitWidth   = true
        label.minimumScaleFactor          = 0.9
        label.lineBreakMode               = .byTruncatingTail
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let firstTeamPlayerName: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Nome Jogador"
        label.textColor = CSTVColors.lightCSTVBlue
        label.adjustsFontSizeToFitWidth   = true
        label.minimumScaleFactor          = 0.9
        label.lineBreakMode               = .byTruncatingTail
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.bottomRight, .topRight], radius: 12.0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews(firstTeamPlayerImg, firstTeamPlayerNickname, firstTeamPlayerName)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = CSTVColors.cellColor
        clipsToBounds = false
        NSLayoutConstraint.activate([
            firstTeamPlayerImg.topAnchor.constraint(equalTo: topAnchor, constant: -3),
            firstTeamPlayerImg.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            firstTeamPlayerImg.heightAnchor.constraint(equalToConstant: 50),
            firstTeamPlayerImg.widthAnchor.constraint(equalToConstant: 50),
            firstTeamPlayerNickname.centerYAnchor.constraint(equalTo: firstTeamPlayerImg.centerYAnchor),
            firstTeamPlayerNickname.trailingAnchor.constraint(equalTo: firstTeamPlayerImg.leadingAnchor, constant: -16),
            firstTeamPlayerNickname.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            firstTeamPlayerName.topAnchor.constraint(equalTo: firstTeamPlayerNickname.bottomAnchor, constant: 6),
            firstTeamPlayerName.leadingAnchor.constraint(equalTo: firstTeamPlayerNickname.leadingAnchor),
            firstTeamPlayerName.trailingAnchor.constraint(equalTo: firstTeamPlayerNickname.trailingAnchor)
        ])
        
    }

}
